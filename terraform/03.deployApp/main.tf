resource "null_resource" "mcp-server-image-build" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Build the Docker image
      docker build -t ${local.mcp_server_image} ../../app/zoo-mcp-server

      # Configure docker to authenticate with GCP
      gcloud auth configure-docker ${var.REGION}-docker.pkg.dev --quiet

      # Push the image
      docker push ${local.mcp_server_image}
    EOT
  }
}

resource "null_resource" "zoo-guide-server-image-build" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Build the Docker image
      docker build -t ${local.zoo_mcp_agent_image} ../../app/zoo-guide-agent

      # Configure docker to authenticate with GCP
      gcloud auth configure-docker ${var.REGION}-docker.pkg.dev --quiet

      # Push the image
      docker push ${local.zoo_mcp_agent_image}
    EOT
  }
}

resource "google_cloud_run_v2_service" "mcpapp" {
  project = local.project_id
  name     = var.mcpserver_name
  location = var.REGION
  client   = "terraform"
  deletion_protection=false

  template {
    containers {
      image = local.mcp_server_image
    }
    service_account = data.terraform_remote_state.config_env.outputs.sa_email
  }

  depends_on = [
    null_resource.mcp-server-image-build
  ]
}

resource "google_cloud_run_v2_service" "zooagent" {
  project = local.project_id
  name     = var.zoo_agent_name
  location = var.REGION
  client   = "terraform"
  deletion_protection=false

  template {
    containers {
      ports {
        container_port = 8000
      }
      startup_probe {
        http_get {
          port = 8000
        }
      }
      image = local.zoo_mcp_agent_image
    }
    service_account = data.terraform_remote_state.config_env.outputs.client_sa_email
  }

  depends_on = [
    null_resource.zoo-guide-server-image-build
  ]
}

resource "google_cloud_run_v2_service_iam_member" "noauth" {
  project = local.project_id
  location = google_cloud_run_v2_service.zooagent.location
  name     = google_cloud_run_v2_service.zooagent.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}