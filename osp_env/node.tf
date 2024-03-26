## Instance

resource "aws_instance" "node" {
  ami                    = "${var.linux_ami}"
  instance_type          = "${var.aws_ami_size}"
  count                  = "0"
  key_name               = "${var.key}"
  subnet_id              = module.networking.subnet_ids[count.index % length(module.networking.subnet_ids)]
  vpc_security_group_ids = module.networking.security_group_ids

  tags = {
    Name     = "node"
    lifetime = "${var.lifetime}"
    email    = "andrew.jones@perforce.com"
  }
}