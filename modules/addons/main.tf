data "aws_eks_addon_version" "this" {
  for_each           = toset(var.addon_names)
  addon_name         = each.key
  kubernetes_version = var.cluster_version
  most_recent        = true
}

resource "aws_eks_addon" "this" {
  for_each      = data.aws_eks_addon_version.this
  cluster_name  = var.cluster_name
  addon_name    = each.key
  addon_version = each.value.version

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  # Only set configuration_values for vpc-cni addon
  configuration_values = each.key == "vpc-cni" ? jsonencode({
    env = {
      ENABLE_PREFIX_DELEGATION = "true"
    }
  }) : null

  tags = var.tags
}

