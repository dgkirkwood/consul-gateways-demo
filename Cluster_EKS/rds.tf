resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "k8sconsuldemo"
  username             = "admin"
  password             = "dbAcce$$123"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.my_rds.name
  vpc_security_group_ids = [aws_security_group.terraform-multi-cloud-k8-demo-cluster.id]
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "my_rds" {
  name       = "k8sconsuldemo"
  subnet_ids = [aws_subnet.multi-cloud-k8-demo[0].id, aws_subnet.multi-cloud-k8-demo[1].id]
}