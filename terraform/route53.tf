data "aws_route53_zone" "px" {
  name = var.px.domain
}

data "aws_elastic_beanstalk_hosted_zone" "px" {}

resource "aws_route53_record" "px" {
  zone_id = data.aws_route53_zone.px.zone_id
  name    = data.aws_route53_zone.px.name
  type    = "A"
  alias {
    name                   = aws_elastic_beanstalk_environment.px.cname
    zone_id                = data.aws_elastic_beanstalk_hosted_zone.px.id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "pxtls" {
  for_each = {
    for dvo in aws_acm_certificate.px.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.px.zone_id
}
