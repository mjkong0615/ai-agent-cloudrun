resource "google_service_account" "service_account" {
  project = local.project_id
  account_id   = "onboard-sa"
  display_name = "Onboard Service Account"
}

resource "google_project_iam_member" "sa-iam" {
  count = length( local.project_iam_roles)
  project = local.project_id
  role = local.project_iam_roles[count.index]
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_artifact_registry_repository" "onboard-repo" {
  project       = local.project_id
  location      = var.REGION
  repository_id = var.repo_id
  description   = var.repo_id
  format        = "docker"
  mode          = "REMOTE_REPOSITORY"
  remote_repository_config {
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }
  cleanup_policy_dry_run = false
}