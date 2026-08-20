# Instância EC2
resource "aws_instance" "web-app-1" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web-app-sg.name, aws_security_group.lb-to-instance-sg.name]
  user_data       = file("./files/ec2_user_data1.sh")

  tags = local.tags
}

resource "aws_instance" "web-app-2" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web-app-sg.name, aws_security_group.lb-to-instance-sg.name]
  user_data       = file("./files/ec2_user_data2.sh")

  tags = local.tags
}
