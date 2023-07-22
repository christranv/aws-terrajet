module "ec2_bastion_keypair" {
  source     = "./modules/keypair"
  project    = local.vars.project
  env        = local.environment
  name       = "ec2-bastion"
  public_key = local.secrets.bastion_public_key
}

module "ec2_bastion" {
  source                 = "./modules/ec2"
  project                = local.vars.project
  env                    = local.environment
  name                   = "bastion"
  instance_type          = local.vars.ec2_bastion.instance_type
  ami                    = local.vars.ec2_bastion.ami
  key_name               = module.ec2_bastion_keypair.key_name
  subnet_id              = element(module.vpc.public_subnet_ids, 0)
  vpc_security_group_ids = [module.bastion_sg.id]
  assign_public_ip       = true
}
