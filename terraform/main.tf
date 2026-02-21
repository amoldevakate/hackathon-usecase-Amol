# -----------------------------------------------------------------------
# Root Terraform Configuration
# Project: hcltech-prod
# Modules: VPC Network + GCS Bucket
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# VPC Network Module
# Creates: hcltech-vpc, hcl-public-subnet, hcl-private-subnet
# + Cloud Router, Cloud NAT, Firewall rules
# -----------------------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  project_id           = var.project_id
  vpc_name             = var.vpc_name
  public_subnet_name   = var.public_subnet_name
  private_subnet_name  = var.private_subnet_name
  public_cidr          = var.public_cidr
  private_cidr         = var.private_cidr
  region               = var.region
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
