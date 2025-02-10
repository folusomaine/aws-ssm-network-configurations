variable "create" {
  description = "Controls whether to create the SSM Session Manager resources"
  type        = bool
  default     = true
}

variable "create_instance_profile" {
  description = "Controls whether to create the EC2 instance profile for SSM"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group name for SSM"
  type        = string
  default     = "ssm-security-group"
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the NACL"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all created resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "Target AWS region"
}