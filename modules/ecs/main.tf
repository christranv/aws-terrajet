resource "aws_ecs_cluster" "this" {
  name = "${upper(var.project)}-${upper(var.env)}-${upper(var.ecs_cluster_name)}"
}
