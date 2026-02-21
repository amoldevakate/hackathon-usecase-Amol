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

variable "region" {
  description = "GCP region for subnets"
  type        = string
  default     = "us-central1"
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}
