# -----------------------------------------------------------------------
# Root Module Variables
# -----------------------------------------------------------------------

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "hcltech-prod"
}

variable "region" {
  description = "Default GCP region for resources"
  type        = string
  default     = "us-central1"
}

# -----------------------------------------------------------------------
# VPC Variables
# -----------------------------------------------------------------------
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "hcltech-vpc"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
  default     = "hcl-public-subnet"
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
  default     = "hcl-private-subnet"
}

variable "public_cidr" {
  description = "CIDR range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_cidr" {
  description = "CIDR range for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# -----------------------------------------------------------------------
# GCS Bucket Variables
# -----------------------------------------------------------------------
variable "bucket_name" {
  description = "Name of the GCS bucket (must be globally unique)"
  type        = string
  default     = "hcl-bucket-2026"
}

variable "bucket_location" {
  description = "Location for the GCS bucket"
  type        = string
  default     = "US"
}

variable "bucket_storage_class" {
  description = "Storage class for the GCS bucket"
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable versioning on the GCS bucket"
  type        = bool
  default     = true
}

variable "bucket_labels" {
  description = "Additional labels to apply to the GCS bucket"
  type        = map(string)
  default = {
    team        = "hcltech"
    cost-center = "hackathon"
  }
}
