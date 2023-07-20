#Create HostedZone
resource "aws_route53_zone" "hostedzone" {
  name          = var.domain_name
  comment       = "DNS for ${var.domain_name} on ${var.env} environment of ${var.project} project"
  force_destroy = false
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
