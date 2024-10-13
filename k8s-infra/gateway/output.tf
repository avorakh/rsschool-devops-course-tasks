output "igw_id" {
  description = "The id of the Internet Gateway."
  value       = aws_internet_gateway.igw.id
}


output "nat_gw_id" {
  description = "The id of the NAT Gateway."
  value       = aws_nat_gateway.nat_gateway.id
}
