locals {
  project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id
  sdp_inspect_template = "projects/${local.project_id}/locations/${var.sdp_region}/inspectTemplates/${var.sdp_inspect_name}"
  sdp_deidentify_template = "projects/${local.project_id}/locations/${var.sdp_region}/deidentifyTemplates/${var.sdp_deidentify_name}"

  project_iam_roles = [
    "roles/storage.objectUser",
    "roles/artifactregistry.admin",
    "roles/run.invoker",
    "roles/aiplatform.user",
    "roles/modelarmor.user"
  ]

}