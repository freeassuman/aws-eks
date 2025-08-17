variable "cluster_name"       { type = string }
variable "cluster_version"    { type = string }
variable "vpc_id"             { type = string }
variable "subnet_ids"         { type = list(string) }
variable "cluster_log_types"  { type = list(string) }
variable "tags"               { type = map(string) default = {} }
