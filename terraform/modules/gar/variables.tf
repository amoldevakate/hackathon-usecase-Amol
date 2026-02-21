variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "location" {
  description = "Region for the Artifact Registry repository"
  type        = string
  default     = "asia-south1"
}

variable "repository_id" {
  description = "The ID of the Artifact Registry repository"
  type        = string
  default     = "hackathon-repo"
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = "Docker repository for hackathon microservices"
}

variable "pusher_service_account_email" {
  description = "Email of the service account that will push images (CI/CD SA)"
  type        = string
}

variable "puller_service_account_email" {
  description = "Email of the service account that will pull images (GKE nodes SA)"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the repository"
  type        = map(string)
  default     = {}
}
