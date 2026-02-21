# -----------------------------------------------------------------------
# GCS Bucket: hcl-bucket-2026
# -----------------------------------------------------------------------
resource "google_storage_bucket" "bucket" {
  project                     = var.project_id
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true

  labels = merge(
    {
      managed-by  = "terraform"
      environment = "production"
      project     = "hcltech-prod"
    },
    var.labels
  )

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    condition {
      age = var.lifecycle_age_days
    }
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }

  lifecycle_rule {
    condition {
      age            = 90
      with_state     = "ARCHIVED"
      num_newer_versions = 3
    }
    action {
      type = "Delete"
    }
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }

  logging {
    log_bucket        = var.bucket_name
    log_object_prefix = "access-logs/"
  }
}
