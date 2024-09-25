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

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

