terraform {
  # Definimos o backend para armazenar o estado (pós bootstrap)
  backend "s3" {
    bucket = "lucas-torres-tfstate"
    key = "tf-infra/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }

  # Definimos os provedores que vamos usar no projeto
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# No bloco 'provider' nós colocamos as configurações específicas do provedor
provider "aws" {
  region = "us-east-1"
}

# Bucket para armazenar o tfstate
resource "aws_s3_bucket" "tfstate" {
  bucket = "lucas-torres-tfstate"
  force_destroy = true

  tags = {
    project = "terraform"
  }
}

# Versioning para versionamento do bucket
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Criptografia para o bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
