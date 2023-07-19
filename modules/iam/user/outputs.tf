output "password" {
  value = var.enable_password ? aws_iam_user_login_profile.this[0].password : null
}
