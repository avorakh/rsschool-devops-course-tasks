# Add GHA IAM role
module "iam" {
  source                   = "./iam/create_gha_iam_role"
  gha_role_name            = var.gha_role_name
  github_oidc_provider_arn = var.github_oidc_provider_arn
  github_repo              = var.github_repo
  environment              = var.environment
  project_name             = var.project_name
}

# Add S3 bucket
module "s3" {
  source       = "./s3/add_bucket"
  bucket_name  = var.bucket_name
  environment  = var.environment
  project_name = var.project_name
}


# Add VPC
module "k8s_infra" {
  source       = "./k8s-infra/vpc"
  vpc_name  = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}
