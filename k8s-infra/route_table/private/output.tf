output "route_table_id" {
  description = "The ID of the routing table"
  value       = aws_route_table.private_route_table.id
}
