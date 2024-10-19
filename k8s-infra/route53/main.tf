resource "aws_route53_zone" "k8s_domain" {
  name =var.k8s_domain_name
  vpc {
    vpc_id = var.vpc_id
  }
  tags = {
    Name        = var.k8s_domain_name
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route53_zone" "k8s_subdomain" {
  name = var.k8s_subdomain_name
  vpc {
    vpc_id = var.vpc_id
  }
  tags = {
    Name        = var.k8s_subdomain_name
    VpcName     = var.vpc_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.k8s_domain.zone_id
  name    = var.k8s_subdomain_name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.k8s_subdomain.name_servers
}

