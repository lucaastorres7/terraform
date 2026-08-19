terraform {
  backend "s3" {
    bucket         = "lucas-torres-tfstate"
    key            = "web-app/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "web-app-sg" {
  name        = "web-app-sg"
  description = "Security Group for allowing internet traffic to web server"

  tags = {
    project = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web-app-allow" {
  security_group_id = aws_security_group.web-app-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"
}

# Instância EC2
resource "aws_instance" "web-app-1" {
  ami             = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web-app-sg.name]
  user_data       = file("./files/ec2_user_data1.sh")

  tags = {
    project = "terraform"
  }
}

resource "aws_instance" "web-app-2" {
  ami             = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web-app-sg.name]
  user_data       = file("./files/ec2_user_data2.sh")

  tags = {
    project = "terraform"
  }
}
