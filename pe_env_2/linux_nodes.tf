## Instance

resource "aws_instance" "linux_node_1" {
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = 4
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]
  vpc_security_group_ids = module.networking.security_group_ids

  tags = {
    Name     = "linux_node_${count.index}"
    lifetime = "1d"
    email    = "andrew.jones@perforce.com"
  }
}