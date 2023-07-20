module "vpc" {
  source        = "./modules/vpc"
  project       = local.vars.project
  env           = local.environment
  region        = local.vars.region
  main_cidr     = local.vars.network.cidr_main
  public_cidrs  = local.vars.network.public_cidrs
  private_cidrs = local.vars.network.private_cidrs
}
