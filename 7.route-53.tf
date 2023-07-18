module "asterisk_acm" {
  source        = "./modules/acm"
  project       = module.vars.env.project.name
  env           = local.environment
  domain_main   = "*.${module.vars.env.domain}"
  region        = module.vars.env.network.region
  is_import_ssl = false
}

module "asterisk_acm_us_east_1" {
  source        = "./modules/acm"
  project       = module.vars.env.project.name
  env           = local.environment
  domain_main   = "*.${module.vars.env.domain}"
  region        = module.vars.env.network.region
  is_import_ssl = false
  providers = {
    aws = aws.us-east-1
  }
}

module "route53_main" {
  source      = "./modules/route-53"
  project     = module.vars.env.project.name
  env         = local.environment
  domain_main = module.vars.env.domain
  acm_domain_validation_options = setunion(
    module.asterisk_acm_us_east_1.domain_validation_options,
    module.static_web_acm.domain_validation_options
  )
}

module "route53_record_api" {
  source         = "./modules/route-53-record"
  useAlias       = false
  hosted_zone_id = module.route53_main.hosted_zone_id
  domain_name    = "api.${module.vars.env.domain}"
  type           = "A"
  ttl            = 60
  records        = [module.ec2_api.public_ip]
}

// Validate SSL certificate
# resource "aws_acm_certificate_validation" "web_cert_validation" {
#   certificate_arn         = module.cloudfront_static_web-acm.cert_arn
#   validation_record_fqdns = module.route-53-web[0].acm_validation_record_fqdns
# }
