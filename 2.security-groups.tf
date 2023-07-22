module "rds_sg" {
  source  = "./modules/security-group"
  project = local.vars.project
  env     = local.environment
  name    = "rds_db"
  vpc_id  = module.vpc.vpc_id
  ingress_port_cidr_targets = [
    {
      port        = local.vars.rds.port
      protocol    = "tcp"
      cidr_blocks = [local.vars.network.cidr_main]
    },
  ]
}

module "ecs_sg" {
  source  = "./modules/security-group"
  project = local.vars.project
  env     = local.environment
  name    = "ecs"
  vpc_id  = module.vpc.vpc_id
  ingress_port_cidr_targets = [ # You can open more port based on your demands
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = [local.vars.network.cidr_main]
    },
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "bastion_sg" {
  source  = "./modules/security-group"
  project = local.vars.project
  env     = local.environment
  name    = "bastion"
  vpc_id  = module.vpc.vpc_id
  ingress_port_cidr_targets = [ # You can open more port based on your demands
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = local.vars.network.trust_ips
    }
  ]
}
