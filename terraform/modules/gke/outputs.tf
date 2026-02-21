# -----------------------------------------------------------------------
# GKE Module Outputs
# -----------------------------------------------------------------------

output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_id" {
  description = "Unique identifier of the GKE cluster"
  value       = google_container_cluster.primary.id
}

output "cluster_endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Public certificate authority of the cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_location" {
  description = "Location (region/zone) of the GKE cluster"
  value       = google_container_cluster.primary.location
}

output "node_pool_name" {
  description = "Name of the node pool"
  value       = google_container_node_pool.primary_nodes.name
}

output "node_pool_id" {
  description = "ID of the node pool"
  value       = google_container_node_pool.primary_nodes.id
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig for the cluster (use with kubectl)"
  value       = <<-EOT
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: ${google_container_cluster.primary.master_auth[0].cluster_ca_certificate}
        server: https://${google_container_cluster.primary.endpoint}
      name: ${google_container_cluster.primary.name}
    contexts:
    - context:
        cluster: ${google_container_cluster.primary.name}
        user: ${google_container_cluster.primary.name}
      name: ${google_container_cluster.primary.name}
    current-context: ${google_container_cluster.primary.name}
    kind: Config
    preferences: {}
    users:
    - name: ${google_container_cluster.primary.name}
      user:
        exec:
          apiVersion: client.authentication.k8s.io/v1beta1
          command: gke-gcloud-auth-plugin
          installHint: Install gke-gcloud-auth-plugin
          provideClusterInfo: true
  EOT
  sensitive = true
}
