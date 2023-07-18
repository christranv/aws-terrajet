output "bucket_id" {
  value = aws_s3_bucket.s3-bucket.id
}

output "bucket_name" {
  value = aws_s3_bucket.s3-bucket.bucket
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.s3-bucket.bucket_regional_domain_name
}

output "s3_website_domain" {
  value = var.enable_static_web ? aws_s3_bucket_website_configuration.s3-static-website[0].website_domain : null
}
