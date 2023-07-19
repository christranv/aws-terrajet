resource "aws_ecs_service" "this" {
  for_each                           = var.ecs_services
  name                               = "${each.key}-service"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this[each.key].arn
  scheduling_strategy                = each.value.scheduling_strategy
  desired_count                      = var.ecs_services[each.key].min_task
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  force_new_deployment               = true
  capacity_provider_strategy {
    capacity_provider = "${var.project}-${var.env}-capacity-provider"
    base              = 0
    weight            = 1
  }
  dynamic "ordered_placement_strategy" {
    for_each = var.service_ordered_placement_strategies
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }
  dynamic "placement_constraints" {
    for_each = var.service_placement_constraints
    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }
  network_configuration {
    security_groups = var.sg_ids
    subnets         = var.private_subnet_ids
  }
  dynamic "load_balancer" {
    for_each = each.value.use_private_nlb || each.value.use_public_nlb ? [1] : []
    content {
      target_group_arn = lookup(var.target_group_arns, each.key)
      container_name   = each.key
      container_port   = lookup(var.ecs_services, each.key).container_port
    }
  }
  dynamic "service_registries" {
    for_each = var.ecs_services[each.key].is_api ? [1] : []
    content {
      registry_arn = aws_service_discovery_service.this[each.key].arn
    }
  }
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  depends_on = [aws_ecs_cluster.this, aws_ecs_capacity_provider.this, var.target_group_arns]
  lifecycle {
    ignore_changes = [capacity_provider_strategy]
  }
}
