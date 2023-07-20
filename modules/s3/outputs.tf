output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "s3_website_domain" {
  value = var.enable_static_web ? aws_s3_bucket_website_configuration.this[0].website_domain : null
}
