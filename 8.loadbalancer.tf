module "network_load_balancer" {
  source  = "./modules/loadbalancer"
  project = local.vars.project
  env     = local.environment
  name    = "nlb"

  is_internal              = false
  vpc_id                   = module.vpc.vpc_id
  subnets_ids              = module.vpc.public_subnet_ids
  ecs_services             = local.vars.ecs_services
  listener_certificate_arn = module.asterisk_acm.cert_arn
  hc_interval              = 5
  hc_timeout               = 20
}
