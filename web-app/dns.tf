resource "aws_route53_zone" "primary" {
  name = var.dns_zone

  tags = local.tags
}

resource "aws_route53_record" "lb" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.web-app-alb.dns_name
    zone_id                = aws_lb.web-app-alb.zone_id
    evaluate_target_health = true
  }
}