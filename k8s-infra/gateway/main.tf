resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = var.igw_name
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_eip" "nat_gateway_ip" {
  domain                    = "vpc"
  associate_with_private_ip = var.private_ip
  depends_on                = [aws_internet_gateway.igw]
  tags = {
    Name        = "NAT Gateway IP"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = var.subnet_id
  depends_on    = [aws_eip.nat_gateway_ip]
  tags = {
    Name        = "NAT Gateway"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}

