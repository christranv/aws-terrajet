locals {
  dev = {
    project = "terrajet"
    aws = {
      account_id = "" # AWS Account Id
      profile    = "aws-terrajet-dev"
      region     = "us-east-1"
    }
    network = {
      cidr_main     = "10.0.0.0/16"
      public_cidrs  = ["10.0.0.0/19", "10.0.32.0/19"]
      private_cidrs = ["10.0.128.0/19", "10.0.160.0/19"]
      trust_ips     = []
    }
    route53 = {
      domain = "aws-terraform.tk"
    }
    rds = {
    }
    ecs = {
      public_key = "" # Public SSH key for EC2 instances
      launch_template = {
        instance_type  = "t2.micro"
        max_spot_price = "0.098" # Set on-demand price of instance_size
      }
      service_discovery_ns          = "ecs.net"
      autoscale_min                 = 1
      autoscale_max                 = 20
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
