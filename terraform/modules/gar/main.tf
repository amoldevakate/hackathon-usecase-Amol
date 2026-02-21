# -----------------------------------------------------------------------
# Artifact Registry Module
# Creates a Docker repository in Google Artifact Registry
# -----------------------------------------------------------------------

resource "google_artifact_registry_repository" "repo" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = "DOCKER"

  labels = var.labels
}

# Grant the service account permission to push/pull images
resource "google_artifact_registry_repository_iam_member" "writer" {
  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${var.pusher_service_account_email}"
}

# Grant the GKE node service account permission to pull images
resource "google_artifact_registry_repository_iam_member" "reader" {
  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.puller_service_account_email}"
}
