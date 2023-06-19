module "vpc" {
  source        = "./modules/vpc"
  main_cidr     = module.vars.env.network.cidr_main
  public_cidrs  = module.vars.env.network.public_cidrs
  private_cidrs = module.vars.env.network.private_cidrs
  project       = module.vars.env.project.name
  region        = module.vars.env.network.region
  env           = local.environment
}

module "ec2-sample" {
  source                 = "./modules/ec2"
  project                = module.vars.env.project.name
  name                   = "ec2-sample"
  env                    = local.environment
  region                 = module.vars.env.network.region
  availability_zone      = module.vars.env.ec2_sample.availability_zone
  instance_type          = module.vars.env.ec2_sample.instance_type
  ami                    = module.vars.env.ec2_sample.ami
  key_name               = module.vars.env.ec2_sample.keypair_name
  subnet_id              = element(module.vpc.public_subnet_ids, 0)
  vpc_security_group_ids = [module.ec2_openvpn_sg.sg_id]
  assign_public_ip       = true
}
