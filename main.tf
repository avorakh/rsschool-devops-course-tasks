# Add GHA IAM role
module "iam" {
  source                   = "./iam/create_gha_iam_role"
  gha_role_name            = var.gha_role_name
  github_oidc_provider_arn = var.github_oidc_provider_arn
  github_repo              = var.github_repo
  environment              = var.environment
  project_name             = var.project_name
}

#Add S3 bucket for kOps state
module "s3-kops-state" {
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


# module "k8s_infra_public_subnet_2" {
#   source       = "./k8s-infra/subnet"
#   vpc_id       = module.k8s_infra_vpc.vpc_id
#   subnet_name  = var.public_subnet_2_name
#   subnet_cidr  = var.public_subnet_2_cidr
#   az           = var.az_2
#   is_public_ip = true
#   vpc_name     = var.vpc_name
#   environment  = var.environment
#   project_name = var.project_name
# }

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

# Internet gateway + NAT Gateway (public)
module "k8s_infra_gateways" {
  source       = "./k8s-infra/gateway"
  igw_name     = var.igw_name
  vpc_id       = module.k8s_infra_vpc.vpc_id
  vpc_name     = var.vpc_name
  subnet_id    = module.k8s_infra_public_subnet_1.subnet_id
  environment  = var.environment
  project_name = var.project_name
}

# Public route table
module "k8s_infra_public_route_table" {
  source           = "./k8s-infra/route_table/public"
  route_table_name = "public_route_table"
  vpc_id           = module.k8s_infra_vpc.vpc_id
  vpc_name         = var.vpc_name
  igw_id           = module.k8s_infra_gateways.igw_id
  environment      = var.environment
  project_name     = var.project_name
}

# Public route table associations
module "k8s_infra_public_route_table_association_public_subnet_1" {
  source         = "./k8s-infra/route_table/association"
  subnet_id      = module.k8s_infra_public_subnet_1.subnet_id
  route_table_id = module.k8s_infra_public_route_table.route_table_id
}

# module "k8s_infra_public_route_table_association_public_subnet_2" {
#   source         = "./k8s-infra/route_table/association"
#   subnet_id      = module.k8s_infra_public_subnet_2.subnet_id
#   route_table_id = module.k8s_infra_public_route_table.route_table_id
# }


# Private route table
module "k8s_infra_private_route_table" {
  source           = "./k8s-infra/route_table/private"
  route_table_name = "private_route_table"
  vpc_id           = module.k8s_infra_vpc.vpc_id
  vpc_name         = var.vpc_name
  nat_gw_id        = module.k8s_infra_gateways.nat_gw_id
  environment      = var.environment
  project_name     = var.project_name
}

# Private route table associations
module "k8s_infra_private_route_table_association_private_subnet_1" {
  source         = "./k8s-infra/route_table/association"
  subnet_id      = module.k8s_infra_private_subnet_1.subnet_id
  route_table_id = module.k8s_infra_private_route_table.route_table_id
}

module "k8s_infra_private_route_table_association_private_subnet_2" {
  source         = "./k8s-infra/route_table/association"
  subnet_id      = module.k8s_infra_private_subnet_2.subnet_id
  route_table_id = module.k8s_infra_private_route_table.route_table_id
}

# Secutity groups
module "k8s_infra_sec_gr_bastion_allow_ssh" {
  source       = "./k8s-infra/security_group/bastion_allow_ssh"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}


module "k8s_infra_sec_gr_private_ssh" {
  source                  = "./k8s-infra/security_group/private_ssh"
  vpc_id                  = module.k8s_infra_vpc.vpc_id
  vpc_name                = var.vpc_name
  sg_bastion_allow_ssh_id = module.k8s_infra_sec_gr_bastion_allow_ssh.sg_bastion_allow_ssh_id
  environment             = var.environment
  project_name            = var.project_name
}


module "k8s_infra_sec_gr_ec2_http" {
  source       = "./k8s-infra/security_group/ec2"
  vpc_id       = module.k8s_infra_vpc.vpc_id
  vpc_name     = var.vpc_name
  environment  = var.environment
  project_name = var.project_name
}


module "k8s_infra_sec_bastion_host" {
  source             = "./k8s-infra/bastion_host"
  bastion_public_key = var.bastion_public_key
  ec2_ami            = var.ec2_ami
  public_subnet_id   = module.k8s_infra_public_subnet_1.subnet_id
  bastion_sg_id      = module.k8s_infra_sec_gr_bastion_allow_ssh.sg_bastion_allow_ssh_id
  ec2_sg_id          = module.k8s_infra_sec_gr_ec2_http.sg_ec2_id
  environment        = var.environment
  project_name       = var.project_name
}


module "k8s_infra_private_subnet_1_control_plane_i1" {
  source            = "./k8s-infra/ec2-control-plane"
  ec2_ami           = var.ec2_ami
  instance_type     = "t3.small"
  subnet_id         = module.k8s_infra_private_subnet_1.subnet_id
  private_ssh_sg_id = module.k8s_infra_sec_gr_private_ssh.sg_private_ssh_id
  ec2_sg_id         = module.k8s_infra_sec_gr_ec2_http.sg_ec2_id
  instance_name     = "control_plane-i1"
  environment       = var.environment
  project_name      = var.project_name
}


module "k8s_infra_private_subnet_2_worker-node_i1" {
  source            = "./k8s-infra/ec2-worker-node"
  ec2_ami           = var.ec2_ami
  instance_type     = "t3.small"
  subnet_id         = module.k8s_infra_private_subnet_2.subnet_id
  private_ssh_sg_id = module.k8s_infra_sec_gr_private_ssh.sg_private_ssh_id
  ec2_sg_id         = module.k8s_infra_sec_gr_ec2_http.sg_ec2_id
  instance_name     = "worker_node-i1"
  environment       = var.environment
  project_name      = var.project_name
}



# module "k8s_infra_public_subnet_2_instance_1" {
#   source            = "./k8s-infra/ec2"
#   ec2_ami           = var.ec2_ami
#   subnet_id         = module.k8s_infra_public_subnet_2.subnet_id
#   private_ssh_sg_id = module.k8s_infra_sec_gr_private_ssh.sg_private_ssh_id
#   ec2_sg_id         = module.k8s_infra_sec_gr_ec2_http.sg_ec2_id
#   instance_name     = "ubuntu_public-subnet-2_i-1"
#   environment       = var.environment
#   project_name      = var.project_name
# }
