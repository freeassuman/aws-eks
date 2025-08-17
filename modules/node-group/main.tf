resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.config.desired_size
    max_size     = var.config.max_size
    min_size     = var.config.min_size
  }

  disk_size      = var.config.disk_size_gb
  instance_types = var.config.instance_types
  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"
  version        = var.cluster_version

  dynamic "labels" {
    for_each = length(var.config.labels) > 0 ? [1] : []
    content {
      labels = var.config.labels
    }
  }

  dynamic "taint" {
    for_each = var.config.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  update_config {
    max_unavailable = 1
  }

  tags = var.tags
}
