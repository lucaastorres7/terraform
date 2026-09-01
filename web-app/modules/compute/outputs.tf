output "instance_ids" {
  value = aws_instance.ec2_instance[*].id
}

output "instance_public_ips" {
  value = aws_instance.ec2_instance[*].public_ip
}

output "instances" {
  value = [for instance in aws_instance.ec2_instance : {
    id         = instance.id
    public_ip  = instance.public_ip
    private_ip = instance.private_ip
  }]
}