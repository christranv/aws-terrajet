resource "aws_s3_bucket" "this" {
  bucket        = "${lower(var.project)}-${lower(var.env)}-${var.name}"
  force_destroy = var.is_destroy
  tags = {
    Name = var.name
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_bucket_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.enable_static_web ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

locals {
  init_objects = flatten(
    [for key, value in var.init_folders :
      [
        for file in fileset(value.localBasePath, "*") : { key = "${key}-${file}", file = file, localBasePath = value.localBasePath, s3BasePath = value.s3BasePath }
      ]
    ]
  )
}

resource "aws_s3_object" "init_objects" {
  for_each = { for item in local.init_objects : item.key => item }
  bucket   = aws_s3_bucket.this.id
  key      = "${each.value.s3BasePath}/${each.value.file}"
  source   = "${each.value.localBasePath}/${each.value.file}"
  etag     = filemd5("${each.value.localBasePath}/${each.value.file}")
}
