# Create a Tanzu Mission Control AWS EKS cluster entry
resource "tanzu-mission-control_ekscluster" "tf_eks_cluster" {
  credential_name = var.credential_name
  region          = var.k8_region
  name            = "sandbox-eks"

  ready_wait_timeout = "45m" // Wait time for cluster operations to finish (default: 30m).
  
  depends_on = [
    tanzu-mission-control_cluster_group.create_cluster_group
  ]
  #lifecycle {
  #  prevent_destroy = true
  #}

  meta {
    description = "eks cluster"
    labels      = { "source" : "terraform" }
  }

  spec {
    cluster_group = var.cluster_group
    #proxy          = "<proxy>"              // Proxy if used

    config {
      role_arn = var.arn_control

      kubernetes_version = "1.26" // Required
      tags               = var.tags
      
      kubernetes_network_config {
        service_cidr = "" // Forces new
      }

      logging {
        api_server         = true
        audit              = true
        authenticator      = true
        controller_manager = false
        scheduler          = true
      }

      vpc { // Required
        enable_private_access = true
        enable_public_access  = true
        public_access_cidrs = ["0.0.0.0/0"]
        security_groups = var.sg_group_ids
        subnet_ids = var.subnet_ids
      }
    }
    nodepool {
      info {
        name        = "np-01"
        description = "default node pool"
      }

      spec {
        role_arn       = var.arn_worker

        ami_type       = "AL2_x86_64"
        capacity_type  = "ON_DEMAND"
        root_disk_size = 70 // Default: 20GiB
        #tags           = { "nptag" : "nptagvalue9" }
        #node_labels    = { "nplabelkey" : "nplabelvalue" }

        subnet_ids        = var.subnet_ids
        #remote_access {
        #  ssh_key         = var.ssh_key_name
        #  security_groups = var.ssh_security_groups
        #}

        scaling_config {
          desired_size = 3
          max_size     = 5
          min_size     = 1
        }

        update_config {
          max_unavailable_nodes = "1"
        }

        instance_types = [
          "t3.medium"
        ]

      }
    }
  }
}
data "shell_script" "tmc_kubeconfig" {
    lifecycle_commands {
        read = <<-EOF
          echo "{\"kubeconfig\": \"$(tanzu tmc cluster kubeconfig get eks.${var.credential_name}.${var.region}.${tanzu-mission-control_ekscluster.tf_eks_cluster.name} -m eks -p eks | base64)\"}" 
        EOF
    }
}