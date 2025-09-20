locals {
  project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id

  project_iam_roles = [
    "roles/storage.objectUser",
    "roles/artifactregistry.admin",
    "roles/run.invoker",
    "roles/aiplatform.user"
  ]

}