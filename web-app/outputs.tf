output "web_app_1_ip_addr" {
  value = aws_instance.web-app-1.public_ip
}

output "web_app_2_ip_addr" {
  value = aws_instance.web-app-2.public_ip
}

output "db_instance_addr" {
  value = aws_db_instance.db-instance.address
}