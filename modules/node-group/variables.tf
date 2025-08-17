variable "cluster_name"    { type = string }
variable "cluster_version" { type = string }
variable "subnet_ids"      { type = list(string) }
variable "node_group_name" { type = string }
variable "node_role_arn"   { type = string }
variable "tags"            { type = map(string) default = {} }

variable "config" {
  type = object({
    min_size       = number
    max_size       = number
    desired_size   = number
    instance_types = list(string)
    disk_size_gb   = number
    labels         = map(string)
    taints         = list(object({
      key    = string
      value  = string
      effect = string
    }))
  })
}
