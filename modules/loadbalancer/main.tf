resource "aws_lb" "this" {
  name                             = "${var.project}-${var.env}-${var.name}"
  load_balancer_type               = "network"
  internal                         = var.is_internal
  subnets                          = var.subnets_ids
  enable_cross_zone_load_balancing = true
}

resource "aws_alb_target_group" "this" {
  for_each               = var.ecs_services
  name                   = "${var.project}-${each.key}-tg"
  target_type            = "ip"
  port                   = each.value.lb_port
  protocol               = each.value.protocol
  vpc_id                 = var.vpc_id
  deregistration_delay   = 15
  connection_termination = false

  health_check {
    protocol            = "HTTP"
    port                = each.value.container_port
    path                = each.value.health_check_path
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = var.hc_interval
    timeout             = var.hc_timeout
  }
  depends_on = [aws_lb.this]
}

# Listener (redirects traffic from the load balancer to the target group)
resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_lb.this.id
  for_each          = aws_alb_target_group.this
  port              = each.value.port
  protocol          = "TLS"
  certificate_arn   = var.listener_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this[each.key].arn
  }
  # depends_on = [aws_alb_target_group.this]
}
