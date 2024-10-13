resource "aws_key_pair" "bastion_keypair" {
  key_name   = var.bastion_key_name
  public_key = file("~/.ssh/${var.bastion_public_key}")
  tags = {
    Name        = "bastion_keypair"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]

  key_name = var.bastion_key_name
  tags = {
    Name        = "bastion_host"
    Environment = var.environment
    Project     = var.project_name
  }
}

