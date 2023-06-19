resource "aws_vpc" "vpc" {
  cidr_block           = var.main_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project}-${var.env}-vpc"
  }
}
