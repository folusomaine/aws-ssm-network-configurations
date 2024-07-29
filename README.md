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

  create                  = true
  create_instance_profile = true
  vpc_id                  = "vpc-12345678"
  subnet_ids              = ["subnet-12345678", "subnet-87654321"]
  region                  = "us-west-2"
  
  tags = {
    Environment = "Production"
    Project     = "SSM"
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
| region | `string` | AWS region | `eu-west-1` | no |
| tags | `map(string)` | A map of tags to add to all resources | `{}` | no |

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
