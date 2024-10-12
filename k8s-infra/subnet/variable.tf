variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "AWS VPC's CIDR value"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "az" {
  description = "Availability zone"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR Block for Subnet"
  type        = string
}

variable "is_public_ip" {
  description = "Is public IP addresses is used"
  type        = bool
  default = false
}
