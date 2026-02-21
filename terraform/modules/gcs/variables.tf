variable "project_id" {
  description = "GCP project ID where the bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket (must be globally unique)"
  type        = string
  default     = "hcl-bucket-2026"
}

variable "location" {
  description = "GCS bucket location (multi-region or region)"
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "Storage class for the bucket"
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be one of: STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "versioning_enabled" {
  description = "Enable object versioning on the bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow deletion of non-empty bucket (use with caution in production)"
  type        = bool
  default     = false
}

variable "lifecycle_age_days" {
  description = "Number of days before objects transition to NEARLINE storage class"
  type        = number
  default     = 30
}

variable "labels" {
  description = "Labels to apply to the GCS bucket"
  type        = map(string)
  default     = {}
}
