output "security_group_id" {
  description = "ID of the created security group"
  value       = var.create ? aws_security_group.ssm_sg[0].id : null
}

output "nacl_id" {
  description = "ID of the created network ACL"
  value       = var.create ? aws_network_acl.ssm_nacl[0].id : null
}

output "instance_profile_name" {
  description = "Name of the created EC2 instance profile (if applicable)"
  value       = var.create && var.create_instance_profile ? aws_iam_instance_profile.ssm_instance_profile[0].name : null
}
