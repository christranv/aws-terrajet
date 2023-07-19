module "vpc" {
  source        = "./modules/vpc"
  project       = module.vars.env.project.name
  env           = local.environment
  region        = module.vars.env.network.region
  main_cidr     = module.vars.env.network.cidr_main
  public_cidrs  = module.vars.env.network.public_cidrs
  private_cidrs = module.vars.env.network.private_cidrs
}
