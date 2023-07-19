output "cloudfront_id" {
  value = aws_cloudfront_distribution.this.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "cloudfront_signing_public_key_id" {
  value = var.enable_signed_url ? aws_cloudfront_public_key.documents_signing_key[0].id : null
}
