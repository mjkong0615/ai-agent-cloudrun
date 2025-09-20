resource "google_service_account" "service_account" {
  project = local.project_id
  account_id   = "onboard-sa"
  display_name = "Onboard Service Account"
}

resource "google_service_account" "onboard-client-sa" {
  project = local.project_id
  account_id   = "onboard-client-sa"
  display_name = "Onboard Client Service Account"
}

resource "google_project_iam_member" "sa-iam" {
  count = length( local.project_iam_roles)
  project = local.project_id
  role = local.project_iam_roles[count.index]
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "client-sa-iam" {
  count = length( local.project_iam_roles)
  project = local.project_id
  role = local.project_iam_roles[count.index]
  member = "serviceAccount:${google_service_account.onboard-client-sa.email}"
}

resource "google_artifact_registry_repository" "onboard-repo" {
  project       = local.project_id
  location      = var.REGION
  repository_id = var.repo_id
  description   = var.repo_id
  format        = "docker"
  cleanup_policy_dry_run = false
}