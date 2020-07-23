


data "aws_network_interface" "rds" {
  filter {
    name   = "subnet-id"
    values = [aws_subnet.multi-cloud-k8-demo[0].id, aws_subnet.multi-cloud-k8-demo[1].id]
  }
  filter {
    name   = "description"
    values = ["RDSNetworkInterface"]

  }
  depends_on = [aws_db_instance.my_rds]
}


output "RDS_IP" {
  value = data.aws_network_interface.rds.private_ip
}