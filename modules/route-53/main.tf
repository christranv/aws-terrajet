#Create HostedZone
resource "aws_route53_zone" "hostedzone" {
  name          = var.domain_main
  comment       = "DNS for ${var.domain_main} on ${var.env} environment of ${var.project} project"
  force_destroy = false
}

resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.hostedzone.id # See aws_route53_zone for how to create this

  name = var.domain_name
  type = "A"

  alias {
    name                   = var.regional_domain_name
    zone_id                = var.regional_zone_id
    evaluate_target_health = true
  }
  depends_on = [aws_route53_zone.hostedzone]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm-cert" {
  for_each = {
    for dvo in var.acm_domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.hostedzone.id
}
