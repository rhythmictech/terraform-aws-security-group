variable "create_before_destroy" {
  default     = false
  description = "Boolean value whether or not to set the 'create_before_destroy' lifecycle rule for this security group"
  type        = bool
}

variable "description" {
  default     = null
  description = "Description to apply to this Security Group"
  type        = string
}

variable "egress_rules" {
  default = [{
    "protocols"   = ["-1"]
    "ports"       = ["0"]
    "description" = ["Allow all outbound traffic"]
    "sources"     = ["0.0.0.0/0", "::/0"]
  }]
  description = "By default this variable allows all outbound traffic -- you can set it to [] to remove this rule. It's a list of maps of lists that comprise the various security group egress rules desired. Valid lists within the map are 'protocols', 'ports', 'description' and 'sources'. All support multiple elements (any valid value for these fields in a security group resource), except for description, which will only use the first value. Sources can be security groups, ipv6 cidrs, ipv4 cidrs or 'self'"
  type        = list(map(any))
}

variable "ingress_rules" {
  default     = []
  description = "A list of maps of lists that comprise the various security group ingress rules desired. Valid lists within the map are 'protocols', 'ports', 'description' and 'sources'. All support multiple elements (any valid value for these fields in a security group resource), except for description, which will only use the first value. Sources can be security groups, ipv6 cidrs, ipv4 cidrs or 'self'"
  type        = list(map(any))
}

variable "name" {
  default     = null
  description = "Name to apply to this security group (Conflicts with name_prefix)"
  type        = string
}

variable "name_prefix" {
  default     = ""
  description = "Name Prefix to apply to this security group (Conflicts with name)"
  type        = string
}

variable "tags" {
  description = "A Map of strings that comprise the desired tags for this security group"
  default     = null
  type        = map(string)
}
variable "vpc_id" {
  description = "ID of the VPC in which this security group should be created (if any)"
  default     = null
  type        = string
}
