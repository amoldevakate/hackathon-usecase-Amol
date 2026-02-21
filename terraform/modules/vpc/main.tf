resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = var.public_subnet_name
  ip_cidr_range = var.public_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "private" {
  name          = var.private_subnet_name
  ip_cidr_range = var.private_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}
