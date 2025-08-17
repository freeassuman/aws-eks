locals {
  subnets_for_cluster = var.private_subnet_ids
}

module "eks" {
  source           = "../../modules/eks"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = var.vpc_id
  subnet_ids       = local.subnets_for_cluster
  cluster_log_types = var.cluster_log_types
  tags             = var.tags
}

module "node_groups" {
  source          = "../../modules/node-group"
  for_each        = var.node_groups
  cluster_name    = module.eks.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = local.subnets_for_cluster
  node_group_name = each.key
  config          = each.value
  tags            = var.tags
  node_role_arn   = module.eks.node_role_arn
}

module "addons" {
  source          = "../../modules/addons"
  cluster_name    = module.eks.cluster_name
  cluster_version = var.cluster_version
  addon_names     = var.addon_names
  tags            = var.tags
}
