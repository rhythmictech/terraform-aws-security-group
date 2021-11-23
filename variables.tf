variable "create_before_destroy" {
  default = "false"
  type    = string
}

variable "description" {
  default = null
  type    = string
}

variable "ingress_rules" {
  type = list(map(any))
}

variable "name_prefix" {
  type = string
}

variable "tags" {
  default = null
  type    = map(string)
}
variable "vpc_id" {
  default = null
  type    = string
}
