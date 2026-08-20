resource "aws_db_instance" "db-instance" {
  allocated_storage = 10
  db_name = "mydb"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "foo"
  password = "foobarbaz"
  skip_final_snapshot = true
}