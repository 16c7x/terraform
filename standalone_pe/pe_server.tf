## Instance
resource "aws_instance" "web-server-instance" {
  ami               = "${var.aws_ami}"
  instance_type     = "${var.aws_ami_size}"
  availability_zone = "eu-west-1a"
  key_name          = "andrew.jones"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Downloading tools" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo yum -y install net-tools >> /var/build.log
              sudo yum -y install wget >> /var/build.log
              sudo yum -y install bind-utils >> /var/build.log
              sudo yum -y install git >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# clong git repo" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              git clone https://github.com/16c7x/terraform.git >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Downloading Puppet agent" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              wget --content-disposition 'https://pm.puppet.com/cgi-bin/download.cgi?dist=el&rel=8&arch=x86_64&ver=latest'  >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Unzip installer" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              gunzip puppet-enterprise-*.tar.gz >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Untar installer" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              tar -xvf puppet-enterprise-*.tar >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Cd into installer dir and install" >> /var/build.log
              sudo echo "########################################" >> /var/build.log      
              cd puppet-enterprise-*x86_64 
              sudo ./puppet-enterprise-installer >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo echo "# Puppet runs" >> /var/build.log
              sudo echo "########################################" >> /var/build.log
              sudo /usr/local/bin/puppet agent -t || true >> /var/build.log
              sudo /usr/local/bin/puppet agent -t || true >> /var/build.log              
              EOF

  tags = {
    Name     = "redhat8 pe server"
    lifetime = "1d"
  }
}