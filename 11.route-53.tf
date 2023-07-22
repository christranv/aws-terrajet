module "asterisk_acm" {
  source      = "./modules/acm"
  project     = local.vars.project
  env         = local.environment
  domain_name = "*.${local.vars.route53.domain}"
}

module "route53_main" {
  source      = "./modules/route-53"
  project     = local.vars.project
  env         = local.environment
  domain_name = local.vars.route53.domain
  acm_domain_validation_options = setunion(
    module.asterisk_acm.domain_validation_options,
    module.cloudfront_web_app_acm.domain_validation_options
  )
}

module "route53_record_web" {
  source         = "./modules/route-53-record"
  hosted_zone_id = module.route53_main.hosted_zone_id
  domain_name    = local.vars.route53.domain
  type           = "A"
  alias = [
    {
      name    = module.cloudfront_web_app.domain_name
      zone_id = module.cloudfront_web_app.hosted_zone_id
    }
  ]
}

module "route53_record_api" {
  source         = "./modules/route-53-record"
  hosted_zone_id = module.route53_main.hosted_zone_id
  domain_name    = "api.${local.vars.route53.domain}"
  type           = "A"
  alias = [
    {
      name    = module.network_load_balancer.dns_name
      zone_id = module.network_load_balancer.zone_id
    }
  ]
}
