variable "gha_role_name" {
  description = "GitHub Actions IAM role name"
  type        = string
}

variable "github_oidc_provider_arn" {
  description = "GitHub OpenID Connect (OIDC) federated identity provider ARN"
  type        = string
}

variable "github_repo" {
  description = "organization and repository to assume a role"
  type        = string
}


