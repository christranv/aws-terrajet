output "aws_iam_instance_profile" {
  value = aws_iam_instance_profile.ecs.name
}

output "scale_role_arn" {
  value = aws_iam_role.ecs_autoscale_role.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
