output "sg_private_ssh_id" {
  description = "ID of security group for private that allows ssh and all egress traffic"
  value       = aws_security_group.private_ssh.id
}
