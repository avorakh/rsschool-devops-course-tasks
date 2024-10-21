resource "aws_security_group" "private_ssh" {
  vpc_id      = var.vpc_id
  name        = "private-ssh"
  description = "security group for private that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.sg_bastion_allow_ssh_id]
  }
  tags = {
    Name        = "private-ssh"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}
