module "ecr" {
  source       = "./modules/ecr"
  env          = local.environment
  project      = local.vars.project
  scan_on_push = true
  ecs_services = local.vars.ecs_services
}
