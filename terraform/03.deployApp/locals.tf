locals {
    project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id
    mcp_server_image="${data.terraform_remote_state.config_env.outputs.docker_repo_uri}/zoo-mcp-server:latest"
    zoo_mcp_agent_image="${data.terraform_remote_state.config_env.outputs.docker_repo_uri}/zoo-guide-agent:latest"
}
