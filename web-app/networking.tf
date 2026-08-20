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
}

# SG Rules
resource "aws_vpc_security_group_ingress_rule" "web-app-allow" {
  security_group_id = aws_security_group.web-app-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "web-lb-allow-http" {
  security_group_id = aws_security_group.web-lb-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "web-lb-allow-https" {
  security_group_id = aws_security_group.web-lb-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
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