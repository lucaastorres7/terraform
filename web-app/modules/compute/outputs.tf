output "instances" {
  value = [for instance in aws_instance.ec2_instance : {
    id         = instance.id
    public_ip  = instance.public_ip
    private_ip = instance.private_ip
  }]
}