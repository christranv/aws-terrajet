terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.7.0"
    }
  }
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
