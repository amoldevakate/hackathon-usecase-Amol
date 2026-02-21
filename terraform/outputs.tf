# -----------------------------------------------------------------------
# Root Module Outputs
# -----------------------------------------------------------------------

# ----- VPC Outputs -----
output "vpc_id" {
  description = "ID of the hcltech-vpc VPC network"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "Name of the hcltech-vpc VPC network"
  value       = module.vpc.vpc_name
}

output "vpc_self_link" {
  description = "Self-link of the VPC network"
  value       = module.vpc.vpc_self_link
}

output "public_subnet_id" {
  description = "ID of the hcl-public-subnet"
  value       = module.vpc.public_subnet_id
}

output "public_subnet_name" {
  description = "Name of the public subnet"
  value       = module.vpc.public_subnet_name
}

output "private_subnet_id" {
  description = "ID of the hcl-private-subnet"
  value       = module.vpc.private_subnet_id
}

output "private_subnet_name" {
  description = "Name of the private subnet"
  value       = module.vpc.private_subnet_name
}

output "cloud_nat_name" {
  description = "Name of the Cloud NAT gateway"
  value       = module.vpc.nat_name
}

# ----- GCS Bucket Outputs -----
output "bucket_name" {
  description = "Name of the GCS bucket hcl-bucket-2026"
  value       = module.gcs.bucket_name
}

output "bucket_url" {
  description = "GCS URI of the bucket (gs://)"
  value       = module.gcs.bucket_url
}

output "bucket_location" {
  description = "Location of the GCS bucket"
  value       = module.gcs.bucket_location
}

output "bucket_storage_class" {
  description = "Storage class of the GCS bucket"
  value       = module.gcs.bucket_storage_class
}

# ------ GKE Cluster Outputs ------
output "gke_cluster_name" {
  description = "Name of the GKE cluster"
  value       = module.gke.cluster_name
}

output "gke_cluster_location" {
  description = "Location of the GKE cluster"
  value       = module.gke.cluster_location
}

output "gke_cluster_endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "gke_node_pool_name" {
  description = "Name of the GKE node pool"
  value       = module.gke.node_pool_name
}
