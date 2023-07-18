
module "vpc" {
  source        = "./modules/vpc"
  main_cidr     = module.vars.env.network.cidr_main
  public_cidrs  = module.vars.env.network.public_cidrs
  private_cidrs = module.vars.env.network.private_cidrs
  project       = module.vars.env.project.name
  region        = module.vars.env.network.region
  env           = local.environment
}
