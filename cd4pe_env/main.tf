# Main config
terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "2.3.1"
    }
  }
}

data "external" "myip" {
  program = [ "bash", "./get_my_ip.sh"]
}

provider "aws" {
  region = "${var.aws_region}"
}

# Contain all the networking configuration for readability
module "networking" {
  source    = "git@github.com:16c7x/terraform_networking.git"
  id        = "demo"
  project   = "demo"
  allow      = concat(["10.128.0.0/9"], [ "109.151.183.6/32", data.external.myip.result.my_ip ])
  to_create = true
  subnet    = null
}
