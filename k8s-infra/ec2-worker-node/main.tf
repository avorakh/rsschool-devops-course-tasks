resource "aws_instance" "worker_node_instance" {
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.private_ssh_sg_id, var.ec2_sg_id]

  key_name  = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo su
              apt update && apt install docker.io -y
              EOF

  tags = {
    Name        = var.instance_name
    Environment = var.environment
    Project     = var.project_name
  }
}

