// Only set alarm for tasks that are enabled in scaling to reduce alarm cost
locals {
  scalable_services = { for k, v in var.ecs_services : k => v if v.min_task < v.max_task && v.max_task > 1 }
  cpu = {
    scale_out_threshold = 60
    scale_in_threshold  = 30
    scale_out_period    = 30
    scale_in_period     = 60
    evaluation_periods  = 4
  }
}

resource "aws_appautoscaling_target" "this" {
  for_each           = local.scalable_services
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this[each.key].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = each.value.min_task
  max_capacity       = each.value.max_task
  role_arn           = var.scale_role_arn

  depends_on = [aws_ecs_service.this]
  lifecycle {
    ignore_changes = [role_arn]
  }
}

#region CPU Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_scale_out" {
  for_each            = aws_appautoscaling_policy.cpu_scale_out
  alarm_name          = "${var.project}-${each.key}-cpu_scale_out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = local.cpu.scale_out_period
  evaluation_periods  = local.cpu.evaluation_periods
  threshold           = local.cpu.scale_out_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this[each.key].name
  }

  alarm_description = "This alarm monitors ECS CPU utilization"
  alarm_actions     = [aws_appautoscaling_policy.cpu_scale_out[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_scale_in" {
  for_each            = aws_appautoscaling_policy.cpu_scale_in
  alarm_name          = "${var.project}-${each.key}-cpu_scale_in"
  comparison_operator = "LessThanThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  evaluation_periods  = local.cpu.evaluation_periods
  statistic           = "Average"
  period              = local.cpu.scale_in_period
  threshold           = local.cpu.scale_in_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this[each.key].name
  }

  alarm_description = "This alarm monitors ECS CPU utilization"
  alarm_actions     = [aws_appautoscaling_policy.cpu_scale_in[each.key].arn]
}
#endregion

#region CPU Scaling
resource "aws_appautoscaling_policy" "cpu_scale_out" {
  for_each           = aws_appautoscaling_target.this
  name               = "CPUScaleOutPolicy"
  policy_type        = "StepScaling"
  resource_id        = each.value.resource_id
  scalable_dimension = each.value.scalable_dimension
  service_namespace  = each.value.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = local.cpu.scale_out_period
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "cpu_scale_in" {
  for_each           = aws_appautoscaling_target.this
  name               = "CPUScaleInPolicy"
  policy_type        = "StepScaling"
  resource_id        = each.value.resource_id
  scalable_dimension = each.value.scalable_dimension
  service_namespace  = each.value.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = local.cpu.scale_in_period
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
#endregion
