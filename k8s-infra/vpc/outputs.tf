output "vpc_id" {
  description = "The id of the VPC."
  value       = aws_vpc.k8s_infra_vpc.id
}
