resource "aws_security_group" "bastion" {
  name        = "Bastion host for ${local.project}"
  description = "Allow SSH access to bastion host and outbound internet access"
  vpc_id      = local.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Project = local.project
  }
}

resource "aws_security_group_rule" "ssh" {
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.allowed_hosts
  security_group_id = aws_security_group.bastion.id
}


resource "aws_security_group_rule" "internal_networks" {
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.internal_networks
  security_group_id = aws_security_group.bastion.id
}
