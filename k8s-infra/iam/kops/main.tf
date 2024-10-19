resource "aws_iam_role" "kops_iam_role" {
  name = "kops"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
  tags = {
    Name        = "kops"
    Environment = var.environment
    Project     = var.project_name
  }
}   


# Create an instance profile for the IAM role
resource "aws_iam_instance_profile" "kops_instance_profile" {
  name = "kops"
  role = aws_iam_role.kops_iam_role.name
    tags = {
    Name        = "kops"
    Environment = var.environment
    Project     = var.project_name
  }
}
