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
  default     = "asia-south1"
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
# GCS Variables
# -----------------------------------------------------------------------
variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
  default     = "hcl-bucket-2026"
}

variable "bucket_location" {
  description = "Location for the GCS bucket"
  type        = string
  default     = "ASIA-SOUTH1"
}

variable "bucket_storage_class" {
  description = "Storage class for the GCS bucket"
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable versioning for the GCS bucket"
  type        = bool
  default     = true
}

variable "bucket_labels" {
  description = "Labels to apply to the GCS bucket"
  type        = map(string)
  default = {
    environment = "production"
    project     = "hcltech"
    managed_by  = "terraform"
  }
}

# -----------------------------------------------------------------------
# GKE Variables
# -----------------------------------------------------------------------
variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "hcltech-gke-cluster"
}

variable "node_service_account" {
  description = "Service account email for GKE nodes"
  type        = string
  default     = "hcltech-terraform-sa@hcltech-prod.iam.gserviceaccount.com"
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for GKE master network"
  type        = string
  default     = "172.16.0.0/28"
}

variable "cluster_secondary_range_name" {
  description = "Secondary IP range name for pods"
  type        = string
  default     = "pods-range"
}

variable "services_secondary_range_name" {
  description = "Secondary IP range name for services"
  type        = string
  default     = "services-range"
}

variable "master_authorized_networks" {
  description = "Authorized networks to access GKE master"
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "All (restrict for production)"
    }
  ]
}

variable "gke_release_channel" {
  description = "GKE release channel (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "REGULAR"
}

variable "node_pool_name" {
  description = "Name of the GKE node pool"
  type        = string
  default     = "hcltech-node-pool"
}

variable "node_count" {
  description = "Initial number of nodes per zone"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Minimum number of nodes for autoscaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for autoscaling"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-standard-2"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB for GKE nodes"
  type        = number
  default     = 50
}

variable "node_tags" {
  description = "Network tags for GKE nodes"
  type        = list(string)
  default     = ["gke-node", "hcltech-gke"]
}

variable "common_labels" {
  description = "Common labels to apply to all resources"
  type        = map(string)
  default = {
    environment = "production"
    project     = "hcltech"
    managed_by  = "terraform"
  }
}
# -----------------------------------------------------------------------
# Artifact Registry Variables
# -----------------------------------------------------------------------
variable "gar_repository_id" {
  description = "The ID of the Artifact Registry Docker repository"
  type        = string
  default     = "hackathon-repo"
}

variable "gar_description" {
  description = "Description of the Artifact Registry repository"
  type        = string
  default     = "Docker repository for hackathon microservices (patient, application, order services)"
}

variable "gar_pusher_sa_email" {
  description = "Service account email that pushes images (GitHub Actions / CI-CD SA)"
  type        = string
  default     = "terraform-sa@hcltech-prod.iam.gserviceaccount.com"
}
