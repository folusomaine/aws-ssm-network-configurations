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

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the NACL"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Must be a valid AWS region name, e.g., us-west-2"
  }
}

variable "tags" {
  description = "A map of tags to add to all created resources"
  type        = map(string)
  default     = {}
}
