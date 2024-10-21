variable "ec2_ami" {
  description = "EC2 instance AMI"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "bastion_sg_id" {
  description = "ID of the security group that allows public ssh"
  type        = string
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

variable "bastion_public_key" {
  default = "bastion_key.pub"
}

variable "bastion_key_name" {
  default = "bastion_keypair"
}
