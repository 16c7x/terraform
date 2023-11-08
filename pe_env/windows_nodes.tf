## Instance

resource "aws_instance" "windows_node" {
  ami                    = "${var.windows_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = 0
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]
  vpc_security_group_ids = module.networking.security_group_ids

  tags = {
    Name     = "windows_node_${count.index}"
    lifetime = "${var.lifetime}"
    email    = "andrew.jones@perforce.com"
  }
}