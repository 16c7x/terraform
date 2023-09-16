## Instance

resource "aws_key_pair" "web-server-instance" {
  key_name   = "my_key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "web-server-instance" {
  ami               = var.aws_ami
  instance_type     = var.aws_ami_size
  availability_zone = "eu-west-1a"
  key_name          = "my_key"

  provisioner "file" {
    source      = "~/.ssh/puppet-control-repo"
    destination = "/tmp/puppet-control-repo"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Installing tools" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo yum -y install git >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# clone git repo" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              git clone https://github.com/16c7x/terraform.git >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# run installer" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo chmod +x /terraform/file_store/pe_server.sh >> /var/build.log
              sudo /terraform/file_store/pe_server.sh >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Finished" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              EOF

  tags = {
    Name     = "redhat8 pe server"
    lifetime = "5d"
  }
}