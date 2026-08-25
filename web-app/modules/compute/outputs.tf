output "instance_ids" {
  value = aws_instance.ec2_instance[*].id
}

output "instance_public_ips" {
  value = aws_instance.ec2_instance[*].public_ip
}