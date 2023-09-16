## Instance

resource "aws_key_pair" "linux_node_1" {
  key_name   = "linux_node_1_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "linux_node_1" {
  ami               = var.aws_ami
  instance_type     = var.aws_ami_size
  availability_zone = "eu-west-1a"
  key_name          = "linux_node_1_key"
  count             = 1

  depends_on = [aws_instance.web-server-instance]

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.linux-node-1-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Fact" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo mkdir -p /etc/facter/facts.d
              sudo echo "role: baseline" > /etc/facter/facts.d/info.yaml
              EOF

  tags = {
    Name     = "compiler node"
    lifetime = "5d"
  }
}