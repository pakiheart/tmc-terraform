resource "tanzu-mission-control_cluster_group" "create_cluster_group" {
  name = var.cluster_group
  meta {
    description = "Create cluster group through terraform"
    labels = {
      "product" : "k8s"
    }
  }
}