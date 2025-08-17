output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "node_group_names" {
  value = [for k, m in module.node_groups : m.node_group_name]
}

output "addon_versions" {
  value = module.addons.addon_versions
}
