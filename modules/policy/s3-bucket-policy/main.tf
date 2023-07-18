data "template_file" "s3-bucket-policy-template" {
  template = file("${path.module}/templates/s3-bucket-policy.json")
  vars = {
    account_id         = var.account_id
    bucket_name        = var.bucket_name
    cloudfront_dist_id = var.cloudfront_dist_id
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.bucket_name
  policy = data.template_file.s3-bucket-policy-template.rendered
}
