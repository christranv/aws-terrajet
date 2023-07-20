module "rds_sg" {
  source                    = "./modules/security-group"
  project                   = local.vars.project
  env                       = local.environment
  name                      = "rds_db"
  vpc_id                    = module.vpc.vpc_id
  ingress_port_cidr_targets = []
}

module "ecs_sg" {
  source  = "./modules/security-group"
  project = local.vars.project
  env     = local.environment
  name    = "ec2-api"
  vpc_id  = module.vpc.vpc_id
  ingress_port_cidr_targets = [ # You can open more port based on your demands
    # {
    #   port        = 22
    #   protocol    = "tcp"
    #   cidr_blocks = local.vars.trust_ips
    # },
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
