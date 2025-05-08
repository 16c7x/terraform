## Instance

resource "aws_instance" "docker_node" {
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = "1"
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]

  vpc_security_group_ids = module.networking.security_group_ids
    root_block_device {
    volume_size = 20
  }

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /etc/facter/facts.d
              echo "---" >> /etc/facter/facts.d/role.yaml
              echo "role: role::docker" >> /etc/facter/facts.d/role.yaml
              EOF

  tags = {
    Name     = "docker_node_${count.index}"
    lifetime = "${var.lifetime}"
    email    = "andrew.jones@perforce.com"
  }
}