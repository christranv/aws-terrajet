module "rds_db" {
  source            = "./modules/rds"
  project           = module.vars.env.project.name
  env               = local.environment
  name              = "main"
  engine            = module.vars.env.rds.engine
  engine_version    = module.vars.env.rds.engine_version
  instance_class    = module.vars.env.rds.instance_class
  sg_ids            = [module.rds_db_sg.sg_id]
  port              = module.vars.env.rds.port
  username          = module.vars.env.rds.username
  password          = module.vars.env.rds.password
  allocated_storage = module.vars.env.rds.allocated_storage
}
