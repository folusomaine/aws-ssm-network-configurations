# AWS Systems Manager Session Manager VPC Firewall Configuration Module

This terraform module sets up the required network firewall configurations for AWS SSM Session Manager. It creates a security group, network ACL, and optionally an EC2 instance profile.

## Features

- Creates a security group with outbound HTTPS access for SSM
- Sets up a network ACL with rules for SSM traffic
- Optionally creates an EC2 instance profile with the required SSM permissions
- Associates the NACL with provided subnet(s)

## Usage

```hcl
module "ssm_session_manager" {
  source = "path/to/module"

  create                  = var.create
  create_instance_profile = var.create_instance_profile
  vpc_id                  = var.vpc_id
  subnet_ids              = var.subnet_ids
  region                  = var.region
  tags = {
    environment = "dev"
  }
}
```

## Inputs

| Name | Type | Description | Default | Required |
|------|------|-------------|---------|:--------:|
| create | `bool` | Controls whether to create the SSM Session Manager resources | `true` | no |
| create_instance_profile | `bool` | Controls whether to create the EC2 instance profile for SSM | `false` | no |
| vpc_id | `string` | ID of the VPC where resources will be created | n/a | yes |
| subnet_ids | `list(string)` | List of subnet IDs to associate with the NACL | `[]` | no |
| tags | `map(string)` | A map of tags to add to all resources | `{}` | no |
| region | `string` | Target AWS region | `eu-west-1` | yes |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | ID of the created security group |
| nacl_id | ID of the created network ACL |
| instance_profile_name | Name of the created EC2 instance profile (if applicable) |

## Notes

- If create is set to false, no resources will be created.
- The EC2 instance profile is only created if both create and create_instance_profile are set to true.
- If no `subnet_ids` are provided, the NACL will be created but not associated with any subnets.
