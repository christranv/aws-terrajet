module "rds_db_sg" {
  source                    = "./modules/security-group"
  project                   = module.vars.env.project.name
  env                       = local.environment
  sg_name                   = "rds_db"
  vpc_id                    = module.vpc.vpc_id
  ingress_port_cidr_targets = []
}

module "ec2_api_sg" {
  source  = "./modules/security-group"
  project = module.vars.env.project.name
  env     = local.environment
  sg_name = "ec2-api"
  vpc_id  = module.vpc.vpc_id
  ingress_port_cidr_targets = [ # You can open more port based on your demands
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = local.trust_ips
    },
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
