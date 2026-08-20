# Instância EC2
resource "aws_instance" "web-app-1" {
  ami             = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web-app-sg.name, aws_security_group.lb-to-instance-sg.name]
  user_data       = file("./files/ec2_user_data1.sh")

  tags = local.tags
}

resource "aws_instance" "web-app-2" {
  ami             = "ami-0332d564d76dbd8d6" # Amazon Linux 2023 kernel-6.18
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web-app-sg.name, aws_security_group.lb-to-instance-sg.name]
  user_data       = file("./files/ec2_user_data2.sh")

  tags = local.tags
}
