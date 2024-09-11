## Input variables

variable "aws_region" {
  description = "A reasonably close region"
  default     = "eu-west-1"
}

variable "linux_ami" {
  description = "Ubuntu 20.04"
  default     = "ami-030f8f64679a7bef6" 
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
  default     = "10d"
}