resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = [aws_ecs_capacity_provider.spot.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.spot.name
  }
}

locals {
  spot_capacity_provider_name = "spot-capacity-provider"
}

resource "aws_ecs_capacity_provider" "spot" {
  name = local.spot_capacity_provider_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status                    = "ENABLED"
      instance_warmup_period    = 300
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 3
      target_capacity           = var.target_capacity
    }
  }
  depends_on = [aws_autoscaling_group.this, aws_ecs_cluster.this]
}

resource "aws_autoscaling_group" "this" {
  name                  = "${lower(var.project)}-spot-asg"
  min_size              = var.autoscale_min
  max_size              = var.autoscale_max
  desired_capacity      = var.autoscale_desired
  health_check_type     = "EC2"
  vpc_zone_identifier   = var.private_subnet_ids
  protect_from_scale_in = true
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}

data "template_file" "config_ecs_instance" {
  template = <<EOF
    #!/bin/bash
    echo -e 'ECS_CLUSTER='${aws_ecs_cluster.this.name}'\nECS_ENABLE_SPOT_INSTANCE_DRAINING=true\nECS_CONTAINER_STOP_TIMEOUT=60s' > /etc/ecs/ecs.config
  EOF
}

resource "aws_launch_template" "this" {
  name_prefix                          = "${var.project}-lt-"
  update_default_version               = true
  ebs_optimized                        = true
  image_id                             = lookup(var.amis, var.region)
  key_name                             = var.keypair_name
  instance_type                        = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = base64encode(data.template_file.config_ecs_instance.rendered)
  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
      max_price                      = var.spot_price
    }
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.sg_ids
  }
  iam_instance_profile {
    name = var.aws_iam_instance_profile
  }
  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Cluster = aws_ecs_cluster.this.name
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

