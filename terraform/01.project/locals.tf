locals {
  org_boolean_policies = [
    "compute.requireOsLogin",
    "compute.requireShieldedVm",
    "iam.disableServiceAccountKeyCreation",
  ]

  org_list_policies = [
    "compute.vmExternalIpAccess",
    "iam.allowedPolicyMemberDomains"
  ]

  project_list_services = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "aiplatform.googleapis.com",
    "containerregistry.googleapis.com",
    "modelarmor.googleapis.com",
    "dlp.googleapis.com"
  ]

  project_iam_roles = [
    "roles/storage.objectUser",
    "roles/artifactregistry.admin"
  ]

}