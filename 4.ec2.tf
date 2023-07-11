module "ec2_api" {
  source                 = "./modules/ec2"
  project                = module.vars.env.project.name
  name                   = "ec2-api"
  env                    = local.environment
  region                 = module.vars.env.network.region
  availability_zone      = module.vars.env.ec2_api.availability_zone
  instance_type          = module.vars.env.ec2_api.instance_type
  ami                    = module.vars.env.ec2_api.ami
  key_name               = module.vars.env.ec2_api.keypair_name
  subnet_id              = element(module.vpc.public_subnet_ids, 0)
  vpc_security_group_ids = [module.ec2_api_sg.sg_id]
  assign_public_ip       = true
}
