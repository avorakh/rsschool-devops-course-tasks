variable "route_table_name" {
  description = "Route table name"
  type        = string
}

variable "public_cidr" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "nat_gw_id" {
  description = "Identifier of a VPC NAT gateway"
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
