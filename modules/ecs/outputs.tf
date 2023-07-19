output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_discovery_dns" {
  value = { for k, v in aws_service_discovery_service.this : k => "${k}.${var.service_discovery_ns}" }
}
