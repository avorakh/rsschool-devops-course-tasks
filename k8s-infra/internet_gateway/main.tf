resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.igw_name
    VpcName        = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}