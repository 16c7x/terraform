## Instance

resource "aws_instance" "linux_node" {
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = "1"
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]
  vpc_security_group_ids = module.networking.security_group_ids

  root_block_device {
    volume_size = 10
  }

  #user_data = <<-EOF
              #!/bin/bash
              sudo echo "# Installing Docker" >> /var/build.log
              for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done 
              sudo apt-get update >> /var/build.log 
              sudo apt-get install ca-certificates curl >> /var/build.log
              sudo install -m 0755 -d /etc/apt/keyrings
              sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
              sudo chmod a+r /etc/apt/keyrings/docker.asc
              echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
              $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
              sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
              sudo yum -y install docker >> /var/build.log
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
              sudo echo "# Installing Portainer" >> /var/build.log
              docker volume create portainer_data
              docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.0      
              docker ps >> /var/build.log
              sudo echo "# Finished" >> /var/build.log
              EOF

  tags = {
    Name     = "portainer"
    lifetime = "${var.lifetime}"
    email    = "andrew.jones@perforce.com"
  }
}