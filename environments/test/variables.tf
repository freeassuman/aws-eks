variable "region" { type = string }
variable "cluster_name" { type = string }
variable "cluster_version" {
  type    = string
  default = "1.32"
}
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "node_groups" {
  description = "Map of node groups"
  type = map(object({
    min_size       = number
    max_size       = number
    desired_size   = number
    instance_types = list(string)
    disk_size_gb   = number
    labels         = map(string)
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}

variable "addon_names" {
  type    = list(string)
  default = ["vpc-cni", "kube-proxy", "coredns", "eks-pod-identity-agent"]
}

variable "cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
