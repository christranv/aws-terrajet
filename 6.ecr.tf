module "ecr" {
  source       = "./modules/ecr"
  env          = local.environment
  project      = module.vars.env.project.name
  scan_on_push = true
  ecs_services = { for k, v in module.vars.env.ecs_services : k => v if v.image_url == null }
}
