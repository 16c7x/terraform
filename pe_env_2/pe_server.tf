## Instance

resource "aws_instance" "pe-server" { 
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = 1
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]
  vpc_security_group_ids = module.networking.security_group_ids

  provisioner "file" {
    source      = "~/.ssh/puppet-control-repo"
    destination = "/tmp/puppet-control-repo"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/${var.key}.pem")
      host        = self.public_ip
    }
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
    Name     = "pe_server_${count.index}"
    lifetime = "1d"
    email    = "andrew.jones@perforce.com"
  }
}