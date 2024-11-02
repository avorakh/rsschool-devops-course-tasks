resource "aws_key_pair" "bastion_keypair" {
  key_name   = var.bastion_key_name
  public_key = file("~/.ssh/${var.bastion_public_key}")
  tags = {
    Name        = var.bastion_key_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id, var.ec2_sg_id]

  key_name  = aws_key_pair.bastion_keypair.key_name
  user_data = <<-EOF
              #!/bin/bash
              curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
              sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
              curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
              EOF
  tags = {
    Name        = "bastion_host"
    Environment = var.environment
    Project     = var.project_name
  }
}

