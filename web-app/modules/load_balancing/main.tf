terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# -- Load Balancer --
resource "aws_lb" "this" {
  name               = var.lb_name
  load_balancer_type = var.lb_type
  internal           = var.is_internal
  ip_address_type    = "ipv4"

  subnets         = var.subnets_ids
  security_groups = [aws_security_group.this.id]

  tags = var.tags
}

# -- Security Group --
resource "aws_security_group" "this" {
  name        = "${var.lb_name}-sg"
  description = "Security group for ${var.lb_name}"

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = var.listener_port
  to_port     = var.listener_port
  ip_protocol = "tcp"

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  tags = var.tags
}
