output "id" {
  value = aws_cloudfront_distribution.this.id
}

output "domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}
