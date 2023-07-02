output "record" {
  value = aws_route53_record.alias.fqdn
}

output "name_servers" {
  value = aws_route53_zone.hostedzone.name_servers
}

output "acm_validation_record_fqdns" {
  value = [for record in aws_route53_record.acm-cert : record.fqdn]
}
