data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}



resource "aws_instance" "consul-agent" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.multi-cloud-k8-demo[0].id
    vpc_security_group_ids = [aws_security_group.consul.id]
    user_data = <<EOF
#!/bin/bash
wget https://releases.hashicorp.com/consul/1.7.3/consul_1.8.0_linux_amd64.zip
sudo apt install unzip
unzip consul_1.8.0_linux_amd64.zip
sudo mv consul /usr/local/bin/
sudo mkdir /opt/consul/
sudo mkdir /opt/consul/config
sudo mkdir /opt/consul/data
sudo mv /home/ubuntu/serverconfig.hcl /opt/consul/config
EOF

    provisioner "file" {
      source      = "/Users/dan/code/consul/connected-clouds/Cluster_EKS/configs/serverconfig.hcl"
      destination = "/home/ubuntu/serverconfig.hcl"
      connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = file("/Users/dan/.ssh/aws-ec2")
        host = aws_instance.consul-agent.public_ip
  }
    }


    key_name = "dk-ec2-key"

    tags = {
        Name = "consul-server"
    }
}


resource "aws_security_group" "consul" {
  name_prefix = "${var.cluster-name}_consul"
  description = "Security group for Consul server"
  vpc_id      = aws_vpc.multi-cloud-k8-demo.id
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.cluster-name
  }
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_server_rpc_inbound" {
  type        = "ingress"
  from_port   = 8300
  to_port     = 8300
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_cli_rpc_inbound" {
  type        = "ingress"
  from_port   = 8400
  to_port     = 8400
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_serf_lan_tcp_inbound" {
  type        = "ingress"
  from_port   = 8301
  to_port     = 8301
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_serf_lan_udp_inbound" {
  type        = "ingress"
  from_port   = 8301
  to_port     = 8301
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_http_api_inbound" {
  type        = "ingress"
  from_port   = 8500
  to_port     = 8500
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_dns_tcp_inbound" {
  type        = "ingress"
  from_port   = 8600
  to_port     = 8600
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_dns_udp_inbound" {
  type        = "ingress"
  from_port   = 8600
  to_port     = 8600
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_grpc_inbound" {
  type        = "ingress"
  from_port   = 8502
  to_port     = 8502
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.consul.id
}

resource "aws_security_group_rule" "allow_egress_all" {
  security_group_id = aws_security_group.consul.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = [
  "0.0.0.0/0"]
}
