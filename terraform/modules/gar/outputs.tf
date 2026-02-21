output "repository_id" {
  description = "The ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.repo.repository_id
}

output "repository_name" {
  description = "The full name of the Artifact Registry repository"
  value       = google_artifact_registry_repository.repo.name
}

output "repository_url" {
  description = "The base URL for pushing/pulling Docker images"
  value       = "${var.location}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
}

output "location" {
  description = "The location of the Artifact Registry repository"
  value       = google_artifact_registry_repository.repo.location
}
