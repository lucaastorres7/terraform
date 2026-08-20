resource "aws_route53_zone" "primary" {
  name = "devopslt.cloud"

  tags = {
    project = "terraform"
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "devopslt.cloud"
  type    = "A"

  alias {
    name                   = aws_lb.web-app-alb.dns_name
    zone_id                = aws_lb.web-app-alb.zone_id
    evaluate_target_health = true
  }
}