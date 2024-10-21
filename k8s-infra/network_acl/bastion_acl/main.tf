resource "aws_network_acl" "bastion_net_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "bastion_net_acl"
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_network_acl_rule" "bastion_allow_ssh_inbound" {
  network_acl_id = aws_network_acl.bastion_net_acl.id
  rule_number    = 100
  egress         = false
  from_port      = 22
  to_port        = 22
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
}

resource "aws_network_acl_rule" "bastion_allow_outbound" {
  network_acl_id = aws_network_acl.bastion_net_acl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
