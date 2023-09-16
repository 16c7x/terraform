## Input variables

# Project URL (needs to match gitlab_profile)
#variable "route53_record" {
#    default = "git.16c7x.com"
#}

# Region
variable "aws_region" {
  default = "eu-west-1"
}

# Availability zone
variable "aws_availability_zone" {
  default = "eu-west-1a"
}

#  AMI 
variable "aws_ami" {
  default = "ami-0f0f1c02e5e4d9d9f" # Redhat 8
}

variable "aws_ami_size" {
  default = "t2.large"
}

variable "ssh_key" {
  description = "Location on disk of the SSH public key to be used for instance SSH access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
