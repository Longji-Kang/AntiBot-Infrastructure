# Lambda Security Group
resource "aws_security_group" "lambda_sg" {
  name        = "${local.naming_prefix}lambda-security-group"
  description = "Security group for admin lambda function"
  vpc_id      = local.vpc_id

  tags = merge(
    {
        Name = "${local.naming_prefix}lambda-security-group"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "lambda_sg_all_egress" {
  security_group_id = aws_security_group.lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# EFS Security Group
resource "aws_security_group" "efs_sg" {
  name        = "${local.naming_prefix}efs-security-group"
  description = "Security group for efs"
  vpc_id      = local.vpc_id

  tags = merge(
    {
        Name = "${local.naming_prefix}efs-security-group"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "efs_all_egress" {
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_vpc_security_group_ingress_rule" "efs_ingress" {
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4         = local.vpc_cidr
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
}