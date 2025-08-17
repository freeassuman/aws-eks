variable "cluster_name"    { type = string }
variable "cluster_version" { type = string }
variable "addon_names"     { type = list(string) }
variable "tags"            { type = map(string) default = {} }
