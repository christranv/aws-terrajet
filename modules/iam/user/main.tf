resource "aws_iam_user" "this" {
  name          = var.username
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "this" {
  count                   = var.enable_password ? 1 : 0
  user                    = aws_iam_user.this.name
  password_length         = 20
  password_reset_required = true
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = var.policy_arn
}
