resource "aws_db_instance" "db-instance" {
  allocated_storage   = 10
  db_name             = var.db_name
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = var.db_size
  username            = var.db_user
  password            = var.db_password
  skip_final_snapshot = true
}