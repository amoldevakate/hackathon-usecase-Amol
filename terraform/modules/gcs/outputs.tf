output "bucket_name" {
  description = "The name of the GCS bucket"
  value       = google_storage_bucket.bucket.name
}

output "bucket_url" {
  description = "The base URL of the GCS bucket (gs://)"
  value       = google_storage_bucket.bucket.url
}

output "bucket_self_link" {
  description = "The URI of the GCS bucket"
  value       = google_storage_bucket.bucket.self_link
}

output "bucket_location" {
  description = "The location of the GCS bucket"
  value       = google_storage_bucket.bucket.location
}

output "bucket_storage_class" {
  description = "The storage class of the GCS bucket"
  value       = google_storage_bucket.bucket.storage_class
}
