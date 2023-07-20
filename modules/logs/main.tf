resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.project}-${var.env}-${var.name}"
  retention_in_days = var.retention_in_days
}
