resource "aws_security_group" "ec2_sg" {
  vpc_id      = var.vpc_id
  name        = "ec2_http"
  description = "security group for EC2 that allows HTTP/HTTPS inbound traffic and all egress traffic"
  tags = {
    Name        = "ec2_http"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}
