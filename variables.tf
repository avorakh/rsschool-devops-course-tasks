# IAM GHA role
variable "github_oidc_provider_arn" {
  description = "GitHub OpenID Connect (OIDC) federated identity provider ARN"
  type        = string
}

variable "github_repo" {
  description = "organization and repository to assume a role"
  type        = string
}

variable "gha_role_name" {
  description = "GitHub Actions IAM role name"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# Common tags
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

# VPC
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "AWS VPC's CIDR value"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnets
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}

# Availability zones
variable "az_1" {
  description = "AZ 1"
  type        = string
}

variable "az_2" {
  description = "AZ 2"
  type        = string
}

# Public subnet 1
variable "public_subnet_1_name" {
  description = "Public subnet 1 name"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  type        = string
}

# Public subnet 2
variable "public_subnet_2_name" {
  description = "Public subnet 2 name"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  type        = string
}

#Private subnet 1
variable "private_subnet_1_name" {
  description = "Private subnet 1 name"
  type        = string
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  type        = string
}

# Private subnet 2
variable "private_subnet_2_name" {
  description = "Private subnet 2 name"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  type        = string
}

# Internet gateway
variable "igw_name" {
  description = "Internet gateway name"
  type        = string
}


# Bastion host
variable "bastion_private_key" {
  default = "bastion_key"
}

variable "bastion_public_key" {
  default = "bastion_key.pub"
}


variable "ec2_ami" {
  description = "EC2 instance AMI"
}

variable "k8s_domain_name" {
  type    = string
  default = "example.com"
}

variable "k8s_subdomain_name" {
  type    = string
  default = "k8s.example.com"
}
