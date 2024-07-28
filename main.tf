# Security Group
resource "aws_security_group" "ssm_sg" {
  count       = var.create ? 1 : 0
  name        = "ssm-security-group"
  description = "Security group for SSM Session Manager"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSM outbound"
  }

  tags = merge(
    var.tags,
    {
      Name = "ssm-security-group"
    }
  )
}

# Network ACL
resource "aws_network_acl" "ssm_nacl" {
  count  = var.create ? 1 : 0
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = merge(
    var.tags,
    {
      Name = "ssm-nacl"
    }
  )
}

# NACL association
resource "aws_network_acl_association" "ssm_nacl_association" {
  count          = var.create ? length(var.subnet_ids) : 0
  network_acl_id = aws_network_acl.ssm_nacl[0].id
  subnet_id      = var.subnet_ids[count.index]
}

# EC2 Instance Profile (if create_instance_profile is true)
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  count = var.create && var.create_instance_profile ? 1 : 0
  name  = "ssm-instance-profile"
  role  = aws_iam_role.ssm_role[0].name
}

resource "aws_iam_role" "ssm_role" {
  count = var.create && var.create_instance_profile ? 1 : 0
  name  = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  count      = var.create && var.create_instance_profile ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role[0].name
}
