# -----------------------------------------------------------------------
# VPC Network
# -----------------------------------------------------------------------
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "HCLTech VPC network - managed by Terraform"
}

# -----------------------------------------------------------------------
# Public Subnet
# -----------------------------------------------------------------------
resource "google_compute_subnetwork" "public" {
  project       = var.project_id
  name          = var.public_subnet_name
  ip_cidr_range = var.public_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  description   = "Public subnet for internet-facing resources"
}

# -----------------------------------------------------------------------
# Private Subnet
# -----------------------------------------------------------------------
resource "google_compute_subnetwork" "private" {
  project                  = var.project_id
  name                     = var.private_subnet_name
  ip_cidr_range            = var.private_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  description              = "Private subnet for internal workloads (GKE, Cloud SQL, etc.)"
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.1.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.2.0.0/20"
  }
}

# -----------------------------------------------------------------------
# Cloud Router (required for Cloud NAT)
# -----------------------------------------------------------------------
resource "google_compute_router" "router" {
  project = var.project_id
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

# -----------------------------------------------------------------------
# Cloud NAT (allows private subnet egress without public IPs)
# -----------------------------------------------------------------------
resource "google_compute_router_nat" "nat" {
  project                            = var.project_id
  name                               = "${var.vpc_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# -----------------------------------------------------------------------
# Firewall: allow internal communication within VPC
# -----------------------------------------------------------------------
resource "google_compute_firewall" "allow_internal" {
  project = var.project_id
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = [var.public_cidr, var.private_cidr]
  description   = "Allow all internal traffic within the VPC"
}

# -----------------------------------------------------------------------
# Firewall: allow health checks from Google
# -----------------------------------------------------------------------
resource "google_compute_firewall" "allow_health_checks" {
  project = var.project_id
  name    = "${var.vpc_name}-allow-health-checks"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  description   = "Allow Google health check probes"
}
