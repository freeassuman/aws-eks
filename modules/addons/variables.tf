variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the add-ons"
  type        = map(string)
  default     = {}
}
variable "addon_names" {
  description = "List of EKS managed add-ons"
  type        = list(string)
  default = [
    "vpc-cni",
    "coredns",
    "kube-proxy",
    "amazon-cloudwatch-observability",
    "eks-pod-identity-agent",
    "metrics-server",
    "cert-manager"
  ]
}
