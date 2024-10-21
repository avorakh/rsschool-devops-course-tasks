resource "aws_network_acl" "vpc_net_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "vpc_net_acl"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}


resource "aws_network_acl_rule" "vpc_allow_inbound" {
  network_acl_id = aws_network_acl.vpc_net_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}

resource "aws_network_acl_rule" "vpc_allow_outbound" {
  network_acl_id = aws_network_acl.vpc_net_acl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}
