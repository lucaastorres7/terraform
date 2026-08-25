resource "aws_instance" "ec2_instance" {
  count = var.instance_count

  ami           = var.instance_ami
  instance_type = var.instance_type
  # Ao usar o <<- a identação do user_data fica alinhado com o último EOF
  user_data     = <<-EOF
                  #!/bin/bash

                  echo "Hello, World from $(hostname -i)!" > index.html
                  python3 -m http.server 8080 &
                  EOF

  security_groups = [aws_security_group.instance_sg.name]

  tags = merge(var.tags, {
    Name = "${var.base_instance_name}_${count.index + 1}"
  })
}