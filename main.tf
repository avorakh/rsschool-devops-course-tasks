# Add GHA IAM role
module "iam" {
  source                   = "./iam/create_gha_iam_role"
  gha_role_name            = var.gha_role_name
  github_oidc_provider_arn = var.github_oidc_provider_arn
  github_repo              = var.github_repo
}

# Add S3 bucket
module "s3" {
  source       = "./s3/add_bucket"
  bucket_name  = var.bucket_name
  environment  = var.environment
  project_name = var.environment
}

