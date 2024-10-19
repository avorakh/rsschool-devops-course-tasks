output "iam_role_arn" {
  description = "The ARN of the IAM role for KOPS."
  value       = aws_iam_role.kops_iam_role.arn
}

output "iam_instance_profile_name" {
  description = "The name of the IAM role for KOPS."
  value       = aws_iam_instance_profile.kops_instance_profile.name
}
