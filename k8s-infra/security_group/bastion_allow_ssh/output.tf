output "sg_bastion_allow_ssh_id" {
  description = "ID of the security group that allows public ssh"
  value       = aws_security_group.bastion_allow_ssh.id
}
