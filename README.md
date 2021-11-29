# terraform-aws-security-group
Module for creating Security Groups in a (hopefully) compact and easy-to-read fashion.

[![tflint](https://github.com/rhythmictech/terraform-terraform-template/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-terraform-template/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-terraform-template/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-terraform-template/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-terraform-template/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-terraform-template/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-terraform-template/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-terraform-template/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-terraform-template/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-terraform-template/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

## Example
Here's what using the module will look like
```hcl
module "sg" {
  source      = "rhythmictech/security-group/aws"
  name_prefix = "TestSecurityGroup"
  vpc_id      = local.vpc_id
  create_before_destroy = true
  egress_rules          = []
  ingress_rules = [
    {
      ports = ["20-21", "22"]
      sources = [
        "10.0.0.0/4",
        "sg-123456789",
        "123.222.1.32/32",
        "::/0"
      ]
      protocols   = ["tcp"]
      description = ["Make ALL the rules"]
    },
    {
      ports = ["55"]
      sources = [
        "sg-4567890123"
      ]
      protocols = ["udp", "tcp"]
    }
  ]

}

```

## About
Module for creating Security Groups in a (hopefully) compact and easy-to-read fashion.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.sg_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_no_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_before_destroy"></a> [create\_before\_destroy](#input\_create\_before\_destroy) | Boolean value whether or not to set the 'create\_before\_destroy' lifecycle rule for this security group | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description to apply to this Security Group | `string` | `null` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | By default this variable allows all outbound traffic -- you can set it to [] to remove this rule. It's a list of maps of lists that comprise the various security group egress rules desired. Valid lists within the map are 'protocols', 'ports', 'description' and 'sources'. All support multiple elements (any valid value for these fields in a security group resource), except for description, which will only use the first value. Sources can be security groups, ipv6 cidrs, ipv4 cidrs or 'self' | `list(map(any))` | <pre>[<br>  {<br>    "description": [<br>      "Allow all outbound traffic"<br>    ],<br>    "ports": [<br>      "0"<br>    ],<br>    "protocols": [<br>      "-1"<br>    ],<br>    "sources": [<br>      "0.0.0.0/0",<br>      "::/0"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | A list of maps of lists that comprise the various security group ingress rules desired. Valid lists within the map are 'protocols', 'ports', 'description' and 'sources'. All support multiple elements (any valid value for these fields in a security group resource), except for description, which will only use the first value. Sources can be security groups, ipv6 cidrs, ipv4 cidrs or 'self' | `list(map(any))` | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name Prefix to apply to this security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A Map of strings that comprise the desired tags for this security group | `map(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC in which this security group should be created (if any) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Getting Started
This workflow has a few prerequisites which are installed through the `./bin/install-x.sh` scripts and are linked below. The install script will also work on your local machine. 

- [pre-commit](https://pre-commit.com)
- [terraform](https://terraform.io)
- [tfenv](https://github.com/tfutils/tfenv)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [tfsec](https://github.com/tfsec/tfsec)
- [tflint](https://github.com/terraform-linters/tflint)

We use `tfenv` to manage `terraform` versions, so the version is defined in the `versions.tf` and `tfenv` installs the latest compliant version.
`pre-commit` is like a package manager for scripts that integrate with git hooks. We use them to run the rest of the tools before apply. 
`terraform-docs` creates the beautiful docs (above),  `tfsec` scans for security no-nos, `tflint` scans for best practices. 
