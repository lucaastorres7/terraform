resource "aws_security_group" "instance_sg" {
  name        = "${var.base_instance_name}-sg"
  description = "Security Group for the ${var.base_instance_name}"

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_sg" {
  for_each = {
    for rule in var.ingress_rule:
      "${rule.protocol}-${rule.port}" => rule # Not perfect since indexes fluctuate a lot (if order changes, resources will be changed)
  }

  security_group_id = aws_security_group.instance_sg.id

  cidr_ipv4   = each.value.ip_address
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = each.value.protocol

  tags = var.tags
}