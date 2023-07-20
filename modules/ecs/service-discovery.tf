resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.service_discovery_ns
  description = "Domain for all ECS services"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "this" {
  for_each = var.ecs_services
  name     = each.key

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.this.id
    routing_policy = "MULTIVALUE"
    dns_records {
      ttl  = 60
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 2
  }

  tags = {
    ServiceName = "${each.key}-service"
  }
}
