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
  #default = "ami-06640050dc3f556bb" # us-east-1
  #default = "ami-0f0f1c02e5e4d9d9f" # eu-west-1
  default = "ami-07d8796a2b0f8d29c"
}
