terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.7.0"
    }
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_main
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
