region         = "eu-west-1"
cluster_name   = "demo-eks"
cluster_version = "1.32"

vpc_id = "vpc-0123456789abcdef0"

private_subnet_ids = [
  "subnet-0aaa1111bbb2222cc",
  "subnet-0ddd3333eee4444ff",
  "subnet-0555aaaabbbb6666c"
]

node_groups = {
  ng-general = {
    min_size       = 2
    max_size       = 6
    desired_size   = 3
    instance_types = ["m6i.large"]
    disk_size_gb   = 50
    labels         = { role = "general" }
    taints         = []
  }
}

tags = {
  Project = "demo"
  Owner   = "platform"
}
