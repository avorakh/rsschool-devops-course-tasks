output "network_acl_id" {
  description = "The ID of the network ACL."
  value       = aws_network_acl.vpc_net_acl.id
}
