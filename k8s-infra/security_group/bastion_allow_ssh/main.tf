resource "aws_security_group" "bastion_allow_ssh" {
  vpc_id      = var.vpc_id
  name        = "bastion-allow-ssh"
  description = "security group for bastion that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "bastion-allow-ssh"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}
