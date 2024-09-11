## Input variables

variable "aws_region" {
  description = "A reasonably close region"
  default     = "eu-west-1"
}

variable "linux_ami" {
  description = "RHEL 8 ami for the linux nodes"
  default      = "ami-0932dacac40965a65"
}

variable "aws_ami_size" {
  description = "AMI size based on PE server, could be smaller for nodes"
  default     = "t2.large"
}

variable "key" {
  description = "AWS Key pair"
  default     = "andrew.jones"
}

variable "lifetime" {
  description = "Tag time before destruction"
  default     = "14d"
}