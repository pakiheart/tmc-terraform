variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "region" {
  type = string
}

variable "env_name" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}


variable "tags" {
  type        = map
  default     = {
    Application = "Kubernetes"
  }
  description = "Key/value tags to assign to all AWS resources"
}

############## EKS VARS #####################################################################
variable "endpoint" {
    type = string
}

variable "vmw_cloud_api_token" {
    type = string
}

variable "credential_name" {
    type = string
}

variable "k8_region" {
    type = string
}

variable "management_cluster_name" {
    type = string
}

variable "provisioner_name" {
    type = string
}

variable "arn_control" {
    type = string
}

variable "arn_worker" {
    type = string
}

variable "cluster_group" {
    type = string
}

variable "sg_group_ids" {
    type = list(string)
}

variable "subnet_ids" {
    type = list(string)
}

variable "namespaces" {
    type = list(string)
}

variable "workspace_name" {
    type = string
}