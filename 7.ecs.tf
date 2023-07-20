module "ecs_policy" {
  source  = "./modules/policy/ecs-policy"
  project = local.vars.project
  env     = local.environment
}

module "ecs_log" {
  source  = "./modules/logs"
  project = local.vars.project
  env     = local.environment
  name    = "ecs"
}

module "ecs_keypair" {
  source     = "./modules/keypair"
  project    = local.vars.project
  env        = local.environment
  name       = "ecs"
  public_key = local.vars.ecs.public_key
}

module "ecs_cluster" {
  source          = "./modules/ecs"
  project         = local.vars.project
  env             = local.environment
  repository_urls = module.ecr.repository_urls
  // Policies
  aws_iam_instance_profile = module.ecs_policy.aws_iam_instance_profile
  scale_role_arn           = module.ecs_policy.scale_role_arn
  task_role_arn            = module.ecs_policy.task_role_arn
  // ECS settings
  keypair_name         = module.ecs_keypair.key_name
  ecs_cluster_name     = "ECS"
  service_discovery_ns = local.vars.ecs.service_discovery_ns
  ecs_services         = local.vars.ecs_services
  region               = local.vars.region
  instance_type        = local.vars.ecs.launch_template.instance_type
  spot_price           = local.vars.ecs.launch_template.max_spot_price
  // Scaling
  target_group_arns                    = module.network_load_balancer.target_group_arns
  autoscale_min                        = local.vars.ecs.autoscale_min
  autoscale_max                        = local.vars.ecs.autoscale_max
  autoscale_desired                    = 1 # This value is decided by ASG capacity provider
  service_ordered_placement_strategies = local.vars.ecs.service_ordered_placement_strategies
  // Network
  vpc_id             = module.vpc.vpc_id
  sg_ids             = [module.ecs_sg.id]
  private_subnet_ids = module.vpc.private_subnet_ids
  // Logging
  log_group = module.ecs_log.name
}
