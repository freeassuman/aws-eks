# Resolve latest compatible add-on versions for this K8s minor
data "aws_eks_addon_version" "this" {
  for_each              = toset(var.addon_names)
  addon_name            = each.key
  kubernetes_version    = var.cluster_version
  most_recent           = true
}

resource "aws_eks_addon" "this" {
  for_each                    = data.aws_eks_addon_version.this
  cluster_name                = var.cluster_name
  addon_name                  = each.key
  addon_version               = each.value.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  # Example: set VPC CNI to manage prefixes (optional)
  dynamic "configuration_values" {
    for_each = each.key == "vpc-cni" ? [1] : []
    content  = jsonencode({ env = { ENABLE_PREFIX_DELEGATION = "true" } })
  }

  tags = var.tags
}

output "addon_arns" {
  value = { for k, a in aws_eks_addon.this : k => a.arn }
}
