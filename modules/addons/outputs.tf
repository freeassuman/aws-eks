output "addon_arns" {
  value = { for k, a in aws_eks_addon.this : k => a.arn }
}

output "addon_versions" {
  value = { for k, a in aws_eks_addon.this : k => a.addon_version }
}
