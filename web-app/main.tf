terraform {
  backend "s3" {
    bucket       = "lucas-torres-tfstate"
    key          = "web-app/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.default_vpc.id ]
  }
}

locals {
  tags = {
    project    = "terraform"
    managed_by = "terraform"
    owner      = "devops"
  }
}

# -- Modules --

module "web-instances" {
  source = "./modules/compute"

  # -- Input Variables --
  instance_count     = 2
  base_instance_name = "web_app"
  tags               = local.tags

  ingress_rule = [
    { ip_address = "0.0.0.0/0", port = 443, protocol = "tcp" },
    { ip_address = "0.0.0.0/0", port = 80, protocol = "tcp" },
    { ip_address = "0.0.0.0/0", port = 8080, protocol = "tcp" },
  ]
}
