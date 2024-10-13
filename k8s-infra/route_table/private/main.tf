resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.public_cidr
    nat_gateway_id = var.nat_gw_id
  }

  tags = {
    Name        = var.route_table_name
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}