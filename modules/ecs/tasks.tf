resource "aws_ecs_task_definition" "this" {
  for_each              = var.ecs_services
  family                = "${each.key}-definition"
  network_mode          = "awsvpc"
  cpu                   = each.value.task_cpu
  memory                = each.value.task_memory
  container_definitions = data.template_file.services[each.key].rendered
  task_role_arn         = var.task_role_arn
}

data "template_file" "services" {
  for_each = var.ecs_services
  template = file("${path.module}/task-templates/${each.key}.json.tpl")

  vars = {
    app_name          = each.key
    image_url         = lookup(var.repository_urls, each.key)
    task_cpu          = each.value.task_cpu
    task_memory       = each.value.task_memory
    container_port    = each.value.container_port
    host_port         = each.value.container_port
    health_check_path = each.value.health_check_path
    log_group         = var.log_group
    region            = var.region
    variables         = jsonencode([for k, v in each.value.variables : { name = k, value = v }])
  }
}
