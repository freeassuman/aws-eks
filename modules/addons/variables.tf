variable "addon_names" {
  description = "List of EKS managed add-ons"
  type        = list(string)
  default = [
    "vpc-cni",
    "coredns",
    "kube-proxy",
    "amazon-cloudwatch-observability",
    "amazon-efs-csi-driver",
    "eks-pod-identity-agent",
    "guardduty-agent",
    "metrics-server",
    "cert-manager"
  ]
}
