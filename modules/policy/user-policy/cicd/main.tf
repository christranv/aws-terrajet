data "template_file" "this" {
  template = file("${path.module}/template/policy.json")
  vars = {
    region                  = var.region
    account_id              = var.account_id
    web_app_bucket_name     = var.web_app_bucket_name
    web_app_distribution_id = var.web_app_distribution_id
    ecs_cluster_name        = var.ecs_cluster_name
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.project}-${var.env}-cicd-user-policy"
  policy = data.template_file.this.rendered
}
