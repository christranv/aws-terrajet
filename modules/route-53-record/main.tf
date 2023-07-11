resource "aws_route53_record" "this" {
  zone_id = var.hosted_zone_id

  name = var.domain_name
  type = var.type

  #Type: "A" - Alias
  dynamic "alias" {
    for_each = var.useAlias ? var.alias : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = true
    }
  }

  # No Alias
  ttl     = var.useAlias ? null : var.ttl
  records = var.useAlias ? null : var.records

  lifecycle {
    create_before_destroy = true
  }
}
