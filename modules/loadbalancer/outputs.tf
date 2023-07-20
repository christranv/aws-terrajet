output "id" {
  value = aws_lb.this.id
}

output "arn" {
  value = aws_lb.this.arn
}

output "dns_name" {
  value = aws_lb.this.dns_name
}

output "zone_id" {
  value = aws_lb.this.zone_id
}

output "target_group_arns" {
  value = { for k, v in aws_alb_target_group.this : k => v.arn }
}
