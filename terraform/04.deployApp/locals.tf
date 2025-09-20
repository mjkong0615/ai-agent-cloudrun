locals {
    project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id
    image="${data.terraform_remote_state.config_env.outputs.docker_repo_uri}/zoo-mcp-server:latest"
}
