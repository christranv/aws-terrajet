locals {
  dev = {
    project    = "terrajet"
    account_id = "084618547938" # Add your AWS account Id
    profile    = "aws-terrajet-dev"
    region     = "us-east-2" # Update your region
    network = {
      cidr_main     = "10.0.0.0/16"
      public_cidrs  = ["10.0.0.0/19", "10.0.32.0/19"]
      private_cidrs = ["10.0.128.0/19", "10.0.160.0/19"]
      trust_ips     = ["0.0.0.0/0"]
    }
    route53 = {
      domain = "terrajet.click"
    }
    rds = {
      engine            = "postgres"
      engine_version    = "12"
      instance_class    = "db.t2.micro"
      port              = 5432
      allocated_storage = 20
    }
    ec2_bastion = {
      instance_type = "t2.micro"
      ami           = "ami-024e6efaf93d85776"
    }
    ecs = {
      launch_template = {
        instance_type  = "t3a.micro"
        max_spot_price = "0.0094" # Set on-demand price of instance_size
      }
      service_discovery_ns          = "ecs.net"
      autoscale_min                 = 1
      autoscale_max                 = 3
      service_placement_constraints = []
      service_ordered_placement_strategies = [
        {
          type  = "spread",
          field = "attribute:ecs.availability-zone"
        },
        {
          type  = "binpack",
          field = "cpu"
        }
      ]
    }
    ecs_services = {
      api = {
        scheduling_strategy = "REPLICA"
        protocol            = "TCP"
        health_check_path   = "/hc"
        container_port      = 80
        lb_port             = 443
        task_cpu            = 128
        task_memory         = 256
        min_task            = 1
        max_task            = 5
        variables = {
          NODE_ENV = "production"
        }
      }
    }
  }
}
