resource "aws_iam_user" "this" {
  name          = var.username
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = var.policy_arn
}
