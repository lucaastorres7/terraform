# Security Group
resource "aws_security_group" "web-app-sg" {
  name        = "web-app-sg"
  description = "Security Group for allowing internet traffic to web server"

  tags = {
    project = "terraform"
  }
}

resource "aws_security_group" "web-lb-sg" {
  name        = "load-balancer-sg"
  description = "Security Group for allowing internet traffic to multiple web servers"

  tags = {
    project = "terraform"
  }
}

resource "aws_security_group" "lb-to-instance-sg" {
  name        = "lb-to-instance-sg"
  description = "Security Group for allowing traffic between ALB and Instances"

  tags = {
    project = "terraform"
  }
}

# SG Rules
resource "aws_vpc_security_group_ingress_rule" "web-app-allow" {
  security_group_id = aws_security_group.web-app-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web-lb-allow-http" {
  security_group_id = aws_security_group.web-lb-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web-lb-allow-https" {
  security_group_id = aws_security_group.web-lb-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb-to-instance-allow" {
  security_group_id = aws_security_group.lb-to-instance-sg.id

  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.web-lb-sg.id

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_egress_rule" "web-app-allow-all-out" {
  security_group_id = aws_security_group.web-app-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_egress_rule" "lb-allow-all-out" {
  security_group_id = aws_security_group.web-lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    project = "terraform"
  }
}

# -- Data --
data "aws_vpc" "default-vpc" {
  default = true
}

data "aws_subnets" "default-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-vpc.id]
  }
}