resource "null_resource" "docker_build_push" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Build the Docker image
      docker build -t ${local.image} ../../zoo-mcp-server

      # Configure docker to authenticate with GCP
      gcloud auth configure-docker ${var.REGION}-docker.pkg.dev --quiet

      # Push the image
      docker push ${local.image}
    EOT
  }
}

resource "google_cloud_run_v2_service" "mcpapp" {
  project = local.project_id
  name     = var.app_name
  location = var.REGION
  client   = "terraform"

  template {
    containers {
      image = local.image
    }
    service_account = data.terraform_remote_state.config_env.outputs.sa_email
  }

  depends_on = [
    null_resource.docker_build_push
  ]
}

# resource "google_cloud_run_v2_service_iam_member" "noauth" {
#   project = local.project_id
#   location = google_cloud_run_v2_service.mcpapp.location
#   name     = google_cloud_run_v2_service.mcpapp.name
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }