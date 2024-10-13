variable "igw_name" {
  description = "Internet gateway name"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
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

variable "subnet_id" {
  description = "The subnet ID to create an association"
  type        = string
}

variable "private_ip" {
  default = "10.0.0.5"
}