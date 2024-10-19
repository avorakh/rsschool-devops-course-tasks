gha_role_name            = "GithubActionsRole"
github_oidc_provider_arn = "arn:aws:iam::503561443439:oidc-provider/token.actions.githubusercontent.com"
github_repo              = "repo:avorakh/rsschool-devops-course-tasks:*"

bucket_name  = "avorakh-devops-course-kops-state"
environment  = "DEV"
project_name = "rsschool-devops-course-tasks"

# VPC
vpc_name = "rs-devops-vpc"
# Availability zones
az_1 = "us-east-1a"
az_2 = "us-east-1b"
# Public Subnet 1
public_subnet_1_name = "Public subnet 1"
public_subnet_1_cidr = "10.0.1.0/24"

#Private subnet 1
private_subnet_1_name = "Private subnet 1"
private_subnet_1_cidr = "10.0.3.0/24"

# Public subnet 2
public_subnet_2_name = "Public subnet 2"
public_subnet_2_cidr = "10.0.2.0/24"

# Private subnet 2
private_subnet_2_name = "Private subnet 2"
private_subnet_2_cidr = "10.0.4.0/24"

# Internet gateway
igw_name = "rs-devops-igw"

# Bastion host
ec2_ami = "ami-0866a3c8686eaeeba"


# DNS names
k8s_domain_name    = "avorakh.publicvm.com"
k8s_subdomain_name = "k8s.avorakh.publicvm.com"