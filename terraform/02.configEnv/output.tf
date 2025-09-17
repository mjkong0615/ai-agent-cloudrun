output "sa_id" {
  description = "ServiceAccount ID"
  value       = google_service_account.service_account.id
}

output "sa_email" {
  description = "ServiceAccount Email"
  value       = google_service_account.service_account.email
}

output "sa_display_name" {
  description = "ServiceAccount Display Name"
  value       = google_service_account.service_account.display_name
}

output "docker_repo_id" {
  value = google_artifact_registry_repository.onboard-repo.id
}

output "docker_repo_name" {
  value = google_artifact_registry_repository.onboard-repo.name
}

output "docker_repo_uri" {
  value = google_artifact_registry_repository.onboard-repo.registry_uri
}