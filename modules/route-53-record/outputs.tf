output "name" {
  value = aws_route53_record.this.name
}

output "record" {
  value = aws_route53_record.this.fqdn
}
