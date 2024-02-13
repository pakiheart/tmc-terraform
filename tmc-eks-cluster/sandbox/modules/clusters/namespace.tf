# Create Tanzu Mission Control namespace with attached set as 'true'
resource "tanzu-mission-control_namespace" "create_namespace_attached" {
  count                   = length(var.namespaces)
  name                    = var.namespaces[count.index] # Required
  cluster_name            = "eks.${var.credential_name}.${var.region}.${tanzu-mission-control_ekscluster.tf_eks_cluster.name}"  # Required
  provisioner_name        = "eks"     # Default: attached
  management_cluster_name = "eks"     # Default: attached
  
  depends_on = [
    tanzu-mission-control_workspace.create_workspace
  ]
  meta {
    description = "Create namespace through terraform"
    labels      = { "key" : "value" }
  }

  spec {
    workspace_name = var.workspace_name
    attach         = true
  }
}