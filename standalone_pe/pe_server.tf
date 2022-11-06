## Instance
resource "aws_instance" "web-server-instance" {
  ami               = "ami-07d8796a2b0f8d29c"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "andrew.jones"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo ooooo a web server > /var/www/html/index.html'
              EOF

  tags = {
    Name     = "ubuntu-web"
    lifetime = "1d"
  }
}