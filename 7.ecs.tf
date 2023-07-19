module "ecs_policy" {
  source  = "./modules/policy/ecs-policy"
  project = module.vars.env.project.name
  env     = local.environment
}

module "ecs_log" {
  source   = "./modules/logs"
  project  = module.vars.env.project.name
  env      = local.environment
  log_name = "${module.vars.env.project.name}-${local.environment}-ecs"
}

module "ecs_keypair" {
  source     = "./modules/keypair"
  project    = module.vars.env.project.name
  env        = local.environment
  name       = "ecs"
  public_key = module.vars.env.ecs.public_key
}

module "ecs_cluster" {
  source          = "./modules/ecs"
  project         = module.vars.env.project.name
  env             = local.environment
  repository_urls = merge(local.ecr_repo_urls, local.pre_defined_repo_urls)
  // Policies
  aws_iam_instance_profile = module.ecs_policy.aws_iam_instance_profile
  scale_role_arn           = module.ecs_policy.scale_role_arn
  task_role_arn            = module.ecs_policy.ecs_task_role_arn
  // ECS settings
  keypair_name         = module.ecs-keypair.key_name
  ecs_cluster_name     = "ECS"
  service_discovery_ns = module.vars.env.ecs.service_discovery_ns
  ecs_services         = module.vars.env.ecs_keypair
  region               = module.vars.env.aws.region
  instance_type        = module.vars.env.launch_template.instance_type
  spot_price           = module.vars.env.launch_template.spot_price
  // Scaling
  target_group_arns                    = merge(module.internal-loadbalancer.target_group_arns, module.internet-facing-loadbalancer.target_group_arns)
  target_capacity                      = module.vars.env.ecs_scale_group.target_capacity
  autoscale_min                        = module.vars.env.ecs_scale_group.autoscale_min
  autoscale_max                        = module.vars.env.ecs_scale_group.autoscale_max
  autoscale_desired                    = 1 # This value is decided by ASG capacity provider
  service_ordered_placement_strategies = module.vars.env.ecs_scale_group.service_ordered_placement_strategies
  // Network
  vpc_id             = module.vpc.vpc_id
  sg_ids             = [module.ecs_sg.sg_id]
  private_subnet_ids = module.vpc.private_subnet_ids
  // Logging
  log_group = module.ecs_log.log_group
}
