provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

provider "tanzu-mission-control" {
  endpoint              = var.endpoint
  vmw_cloud_api_token   = var.vmw_cloud_api_token
}

terraform {
  required_version = "1.7.3"
  required_providers {
    tanzu-mission-control = {
      source = "vmware/tanzu-mission-control"
      version = "1.4.2"
    }
  }

  backend "s3" {
    key    = "tfstate-ra"
    region = "us-west-2"
  } 
}

locals {
  default_tags = {
    Environment = "${var.env_name}"
    Application = "Kubernetes"
  }

  actual_tags = "${merge(var.tags, local.default_tags)}"
}


module "k8s-clusters" {
  source = "./modules/clusters"
  
  #cluster_names             = "${var.cluster_names}"
  availability_zones        = "${var.availability_zones}"
  endpoint                  = "${var.endpoint}"
  vmw_cloud_api_token       = "${var.vmw_cloud_api_token}" 
  credential_name           = "${var.credential_name}"
  management_cluster_name   = "${var.management_cluster_name}" 
  provisioner_name          = "${var.provisioner_name}" 
  arn_control               = "${var.arn_control}" 
  arn_worker                = "${var.arn_worker}" 
  k8_region                 = "${var.k8_region}" 
  cluster_group             = "${var.cluster_group}"
  sg_group_ids              = "${var.sg_group_ids}"
  vpc_id                    = "${var.vpc_id}"
  vpc_cidr                  = "${var.vpc_cidr}"
  region                    = "${var.region}"
  env_name                  = "${var.env_name}"
  subnet_ids                = "${var.subnet_ids}"
  tags                      = "${local.actual_tags}"
  workspace_name            = "${var.workspace_name}"
  namespaces                = "${var.namespaces}"
}