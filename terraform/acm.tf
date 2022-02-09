resource "aws_acm_certificate" "px" {
  domain_name       = var.px.domain
  validation_method = "DNS"
}
