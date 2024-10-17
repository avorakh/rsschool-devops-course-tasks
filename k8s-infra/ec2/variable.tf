variable "ec2_ami" {
  description = "EC2 instance AMI"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Instance name"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "private_ssh_sg_id" {
  description = "ID of security group for private that allows ssh and all egress traffic"
}

variable "ec2_sg_id" {
  description = "ID of the security group that allows public http/https"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "key_name" {
  default = "bastion_keypair"
}
