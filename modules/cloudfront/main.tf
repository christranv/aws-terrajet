resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "Access control for S3 bucket ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.enable_static_web ? "index.html" : null

  origin {
    origin_id                = var.bucket_name
    domain_name              = var.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name
    compress         = true

    trusted_key_groups = var.enable_signed_url ? [aws_cloudfront_key_group.documents_signing_key_group[0].id] : []

    cache_policy_id            = aws_cloudfront_cache_policy.this.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.this.id
    viewer_protocol_policy     = "redirect-to-https"
  }

  # custom_error_response
  dynamic "custom_error_response" {
    for_each = var.enable_static_web ? [1] : []
    content {
      error_caching_min_ttl = "0"
      error_code            = "403"
      response_code         = "200"
      response_page_path    = "/index.html"
    }
  }
  dynamic "custom_error_response" {
    for_each = var.enable_static_web ? [1] : []
    content {
      error_caching_min_ttl = "0"
      error_code            = "404"
      response_code         = "200"
      response_page_path    = "/index.html"
    }
  }
  price_class = "PriceClass_200"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = [var.domain] # Uncomment when have issued ssl
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.cert_arn
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_cache_policy" "this" {
  name        = "${var.bucket_name}-cache-policy"
  default_ttl = var.cache_ttl
  min_ttl     = var.cache_ttl
  max_ttl     = var.cache_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

/**
* CORS policy
**/
resource "aws_cloudfront_response_headers_policy" "this" {
  name = "${var.bucket_name}-response-headers-policy"

  cors_config {
    access_control_allow_credentials = true

    access_control_allow_headers {
      items = ["Content-Type", "Content-Length", "Connection", "x-amz-storage-class", "x-amz-server-side-encryption", "Date", "Vary", "X-Cache", "X-Amz-Cf-Pop", "X-Amz-Cf-Id", "Age"]
    }

    access_control_allow_methods {
      items = ["GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "DELETE"]
    }

    access_control_allow_origins {
      items = var.allow_domains
    }

    origin_override = true
  }
}
