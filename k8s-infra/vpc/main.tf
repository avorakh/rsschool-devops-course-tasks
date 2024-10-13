resource "aws_vpc" "k8s_infra_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}
