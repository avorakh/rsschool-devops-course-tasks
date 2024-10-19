variable "k8s_domain_name" {
  type        = string
  default = "example.com"
}

variable "k8s_subdomain_name" {
  type        = string
  default = "k8s.example.com"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
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