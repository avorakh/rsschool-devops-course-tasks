resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = var.is_public_ip
  tags = {
    Name        = var.subnet_name
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}
