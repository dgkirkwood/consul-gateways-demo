datacenter = "dc-aws"
data_dir = "/opt/consul/data"
server = false
ui = true
connect  {
        enabled = true
}
client_addr = "0.0.0.0"
ports {
    grpc = 8502
}