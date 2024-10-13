output "route_table_id" {
  description = "The ID of the routing table"
  value       = aws_route_table.public_route_table.id
}
