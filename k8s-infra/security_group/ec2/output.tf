output "sg_ec2_id" {
  description = "ID of the security group that allows HTTP, HTTPS inbound traffic and all egress traffic"
  value       = aws_security_group.ec2_sg.id
}
