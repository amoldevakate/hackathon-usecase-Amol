# -----------------------------------------------------------------------
# Root Terraform Configuration
# Project: hcltech-prod
# Modules: VPC Network + GCS Bucket + GKE Cluster
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# VPC Network Module
# Creates: hcltech-vpc, hcl-public-subnet, hcl-private-subnet
# + Cloud Router, Cloud NAT, Firewall rules
# -----------------------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  project_id          = var.project_id
  vpc_name            = var.vpc_name
  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  public_cidr         = var.public_cidr
  private_cidr        = var.private_cidr
  region              = var.region
}

# -----------------------------------------------------------------------
# GCS Bucket Module
# Creates: hcl-bucket-2026 with versioning, lifecycle, CORS
# -----------------------------------------------------------------------
module "gcs" {
  source = "./modules/gcs"

  project_id         = var.project_id
  bucket_name        = var.bucket_name
  location           = var.bucket_location
  storage_class      = var.bucket_storage_class
  versioning_enabled = var.versioning_enabled
  force_destroy      = false
  lifecycle_age_days = 30
  labels             = var.bucket_labels
}

# -----------------------------------------------------------------------
# GKE Cluster Module
# Creates: Private GKE cluster with autoscaling node pool
# -----------------------------------------------------------------------
module "gke" {
  source = "./modules/gke"

  project_id           = var.project_id
  region               = var.region
  cluster_name         = var.gke_cluster_name
  network              = module.vpc.vpc_name
  subnetwork           = module.vpc.private_subnet_name
  node_service_account = var.node_service_account

  master_ipv4_cidr_block         = var.master_ipv4_cidr_block
  cluster_secondary_range_name   = var.cluster_secondary_range_name
  services_secondary_range_name  = var.services_secondary_range_name
  master_authorized_networks     = var.master_authorized_networks
  release_channel                = var.gke_release_channel

  node_pool_name  = var.node_pool_name
  node_count      = var.node_count
  min_node_count  = var.min_node_count
  max_node_count  = var.max_node_count
  machine_type    = var.machine_type
  disk_size_gb    = var.disk_size_gb
  node_tags       = var.node_tags
  labels          = var.common_labels

  depends_on = [module.vpc]
}

# -----------------------------------------------------------------------
# Artifact Registry Module
# Creates: hackathon-repo Docker registry in asia-south1
# -----------------------------------------------------------------------
module "gar" {
  source = "./modules/gar"

  project_id                   = var.project_id
  location                     = var.region
  repository_id                = var.gar_repository_id
  description                  = var.gar_description
  pusher_service_account_email = var.gar_pusher_sa_email
  puller_service_account_email = var.node_service_account
  labels                       = var.common_labels
}
