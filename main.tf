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
module "k8s_infra_vpc" {
  source       = "./k8s-infra/vpc"
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}

# Add subnets
module "k8s_infra_public_subnet_1" {
  source       = "./k8s-infra/subnet"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  subnet_name  = var.public_subnet_1_name
  subnet_cidr  = var.public_subnet_1_cidr
  az           = var.az_1
  is_public_ip = true
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}

module "k8s_infra_private_subnet_1" {
  source       = "./k8s-infra/subnet"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  subnet_name  = var.private_subnet_1_name
  subnet_cidr  = var.private_subnet_1_cidr
  az           = var.az_1
  is_public_ip = false
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}


module "k8s_infra_public_subnet_2" {
  source       = "./k8s-infra/subnet"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  subnet_name  = var.public_subnet_2_name
  subnet_cidr  = var.public_subnet_2_cidr
  az           = var.az_2
  is_public_ip = true
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}

module "k8s_infra_private_subnet_2" {
  source       = "./k8s-infra/subnet"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  subnet_name  = var.private_subnet_2_name
  subnet_cidr  = var.private_subnet_2_cidr
  az           = var.az_2
  is_public_ip = false
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}

# Internet gateway
module "k8s_infra_internet_gateway" {
  source       = "./k8s-infra/internet_gateway"
  igw_name     = var.igw_name
  vpc_id       = module.k8s_infra_vpc.vpc_id
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}