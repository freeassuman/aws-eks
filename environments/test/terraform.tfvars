region          = "eu-west-1"
cluster_name    = "suman-eks-test"
cluster_version = "1.30"
vpc_id          = "vpc-027857c7c38740a74"

private_subnet_ids = [
  "subnet-0920379bf86d5f976",
  "subnet-0db2e3e8339da2d96"
]

node_groups = {
  ng-suman-eks-test = {
    min_size       = 0
    max_size       = 2
    desired_size   = 1
    instance_types = ["t3.medium"]
    disk_size_gb   = 50
    labels         = { role = "general" }
    taints         = []
  }
}

tags = {
  Project = "demo-test"
  Owner   = "platform"
}

addon_names = [
  "vpc-cni",
  "coredns",
  "kube-proxy",
  "amazon-cloudwatch-observability",
  "metrics-server",
  "cert-manager"
]

