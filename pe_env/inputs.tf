## Input variables

variable "aws_region" {
  description = "A reasonably close region"
  default     = "eu-west-1"
}

variable "linux_ami" {
  description = "RHEL 8 ami for the Windows nodes"
  default     = "ami-0f0f1c02e5e4d9d9f" 
}

## Minimum of 2 Linux nodes or outputs.tf will fail
variable "linux_count" {
  description = "How many Linux nodes to build"
  default     = "2" 
}

variable "windows_ami" {
  description = "Windows 2012 ami for the Windows nodes"
  #default     = "ami-08456538e3a727106"
  default     = "ami-0855cc7dacc5f76eb"
}

variable "windows_count" {
  description = "How many Windows nodes to build"
  default     = "0" 
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
  default     = "2d"
}