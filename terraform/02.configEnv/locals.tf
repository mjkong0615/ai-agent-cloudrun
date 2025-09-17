locals {
  project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id
  org_boolean_policies = [
    "compute.requireOsLogin",
    "compute.requireShieldedVm",
    "iam.disableServiceAccountKeyCreation"
  ]

  org_list_policies = [
    "compute.vmExternalIpAccess"
  ]

  project_list_services = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com"
  ]

  project_iam_roles = [
    "roles/storage.objectUser"
  ]

}