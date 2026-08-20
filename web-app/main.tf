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
  region = "us-east-1"
}

locals {
  tags = {
    project    = "terraform"
    managed_by = "terraform"
    owner      = "devops"
  }
}