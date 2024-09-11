## Instance

resource "aws_instance" "test_node" {
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = "1"
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]

  vpc_security_group_ids = module.networking.security_group_ids
    root_block_device {
    volume_size = 20
  }

  tags = {
    Name     = "test_node_${count.index}"
    lifetime = "${var.lifetime}"
    email    = "andrew.jones@perforce.com"
  }
}