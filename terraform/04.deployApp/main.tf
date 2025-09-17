resource "null_resource" "docker_build_push" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Build the Docker image
      docker build -t ${data.terraform_remote_state.config_env.outputs.docker_repo_uri}/mcpapp:latest ../../mcp-on-cloudrun

      # Configure docker to authenticate with GCP
      gcloud auth configure-docker ${data.terraform_remote_state.config_env.outputs.docker_repo_uri} --quiet

      # Push the image
      docker push ${data.terraform_remote_state.config_env.outputs.docker_repo_uri}/mcpapp:latest
    EOT
  }
}