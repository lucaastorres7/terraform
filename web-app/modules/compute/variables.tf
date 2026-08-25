variable "base_instance_name" {
  type        = string
  description = "Base name of the instance (ex: my_app)"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to be created"
  default     = 1
}

variable "instance_ami" {
  type        = string
  description = "AMI used to create the EC2 instance"
  default     = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
}

variable "instance_type" {
  type        = string
  description = "Type/Size of the EC2 instance"
  default     = "t3.micro"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "ingress_rule" {
  type = list(object({
    port       = number
    protocol   = string
    ip_address = string
  }))
  description = <<EOT
    ingress_rule = {
      port: "Which port to be allowed in the security group"
      protocol: "Which protocol will be used in this rule"
      ip_address: "Which IP address (186.80.10.200) or CIDR (0.0.0.0/0) will be affected by the rule"
    }
  EOT
  default = [{
    ip_address = "0.0.0.0/0"
    port       = 443
    protocol   = "tcp"
  }]
}