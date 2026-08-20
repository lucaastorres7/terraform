# General Vars
variable "region" {
  type = string
  description = "Region used for provider"
  default = "us-east-1"
}

# Compute Variables
variable "instance_type" {
  type = string
  description = "EC2 Instance Type"
  default = "t3.micro"
}

variable "instance_ami" {
  type = string
  description = "Amazon Machine Image to use for an EC2 instance"
  default = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
}

# Route 53
variable "dns_zone" {
  type = string
  description = "Route 53 zone"
}

variable "domain" {
  type = string
  description = "Domain for the website"
}

# Database Variables
variable "db_size" {
  type = string
  description = "Size of the database instance"
  default = "db.t3.micro"
}

variable "db_name" {
  type = string
  description = "Name of the database"
}

variable "db_user" {
  type = string
  description = "Username for database"
  default = "dbuser"
}

variable "db_password" {
  sensitive = true
  type = string
  description = "Password for database"
}