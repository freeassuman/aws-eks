data "aws_partition" "this" {}
data "tls_certificate" "oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "eks" {
  name               = "${var.cluster_name}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "eks_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["eks.amazonaws.com"] }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_security_group" "cluster" {
  name   = "${var.cluster_name}-cluster-sg"
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { "kubernetes.io/cluster/${var.cluster_name}" = "owned" })
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids         = var.subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = false
    security_group_ids = [aws_security_group.cluster.id]
  }

  enabled_cluster_log_types = var.cluster_log_types
  tags = var.tags
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
  client_id_list  = ["sts.${data.aws_partition.this.dns_suffix}"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  tags            = var.tags
}

resource "aws_iam_role" "nodes" {
  name               = "${var.cluster_name}-nodes-role"
  assume_role_policy = data.aws_iam_policy_document.nodes_assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "nodes_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["ec2.amazonaws.com"] }
  }
}

resource "aws_iam_role_policy_attachment" "worker_node" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "ecr_ro" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
