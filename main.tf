locals {
  security_group_id = var.create_before_destroy ? aws_security_group.sg_lifecycle[0].id : aws_security_group.sg_no_lifecycle[0].id
  ingress_rules = flatten([
    for rule in var.ingress_rules : [
      for port in rule.ports : [
        for source in rule.sources : [
          for protocol in rule.protocols : {
            description = try(rule.description, null)
            port        = port
            protocol    = protocol
            source      = source
          }
        ]
      ]
    ]
  ])
  egress_rules = flatten([
    for rule in var.egress_rules : [
      for port in rule.ports : [
        for source in rule.sources : [
          for protocol in rule.protocols : {
            description = try(rule.description, null)
            port        = port
            protocol    = protocol
            source      = source
          }
        ]
      ]
    ]
  ])
}

resource "aws_security_group" "sg_lifecycle" {
  count       = var.create_before_destroy ? 1 : 0
  name        = var.name
  name_prefix = var.name_prefix != "" ? var.name_prefix : null
  description = var.description
  tags        = var.tags
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sg_no_lifecycle" {
  count       = var.create_before_destroy ? 0 : 1
  name        = var.name
  name_prefix = var.name_prefix != "" ? var.name_prefix : null
  description = var.description
  tags        = var.tags
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  for_each = {
    for rule in local.ingress_rules : "${rule.port}_${rule.source}_${rule.protocol}" => rule
  }
  cidr_blocks              = length(regexall("^([0-9]{1,3}.?){4}/[0-9]{1,2}", each.value.source)) > 0 ? [each.value.source] : null
  description              = try(each.value.description[0], null)
  from_port                = split("-", each.value.port)[0]
  ipv6_cidr_blocks         = length(regexall("::/", each.value.source)) > 0 ? [each.value.source] : null
  protocol                 = each.value.protocol
  security_group_id        = local.security_group_id
  self                     = length(regexall("^(?i)self$", each.value.source)) > 0 ? true : null
  source_security_group_id = length(regexall("sg-[a-zA-Z0-9]+", each.value.source)) > 0 ? each.value.source : null
  to_port                  = try(split("-", each.value.port)[1], each.value.port)
  type                     = "ingress"
}

#tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "egress" {
  for_each = {
    for rule in local.egress_rules : "${rule.port}_${rule.source}_${rule.protocol}" => rule
  }
  cidr_blocks              = length(regexall("^([0-9]{1,3}.?){4}/[0-9]{1,2}", each.value.source)) > 0 ? [each.value.source] : null
  description              = try(each.value.description[0], null)
  from_port                = split("-", each.value.port)[0]
  ipv6_cidr_blocks         = length(regexall("::/", each.value.source)) > 0 ? [each.value.source] : null
  protocol                 = each.value.protocol
  security_group_id        = local.security_group_id
  self                     = length(regexall("^(?i)self$", each.value.source)) > 0 ? true : null
  source_security_group_id = length(regexall("sg-[a-zA-Z0-9]+", each.value.source)) > 0 ? each.value.source : null
  to_port                  = try(split("-", each.value.port)[1], each.value.port)
  type                     = "egress"
}
