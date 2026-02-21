# -----------------------------------------------------------------------
# GKE Module Variables
# -----------------------------------------------------------------------

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region for GKE cluster"
  type        = string
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "hcltech-gke-cluster"
}

variable "network" {
  description = "VPC network name or self_link"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork name or self_link for GKE cluster"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for the master network"
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
  description = "Authorized networks to access the master endpoint"
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "All (change for production)"
    }
  ]
}

variable "release_channel" {
  description = "Release channel for GKE cluster (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "REGULAR"
}

# -----------------------------------------------------------------------
# Node Pool Variables
# -----------------------------------------------------------------------

variable "node_pool_name" {
  description = "Name of the default node pool"
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
  description = "Disk size in GB for each node"
  type        = number
  default     = 100
}

variable "node_service_account" {
  description = "Service account for GKE nodes"
  type        = string
}

variable "node_tags" {
  description = "Network tags for GKE nodes"
  type        = list(string)
  default     = ["gke-node", "hcltech-gke"]
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default = {
    environment = "production"
    project     = "hcltech"
    managed_by  = "terraform"
  }
}
