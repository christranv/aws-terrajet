output "hosted_zone_id" {
  value = aws_route53_zone.hostedzone.id
}

output "name_servers" {
  value = aws_route53_zone.hostedzone.name_servers
}

output "acm_validation_record_fqdns" {
  value = [for record in aws_route53_record.acm-cert : record.fqdn]
}
