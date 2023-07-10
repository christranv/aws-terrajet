module "route-53-web" {
  source                        = "./modules/route-53"
  project                       = module.vars.env.project.name
  env                           = local.environment
  domain_main                   = module.vars.env.network.domains.web
  domain_name                   = module.vars.env.network.domains.web
  regional_domain_name          = module.cloudfront_static_web.cloudfront_domain_name
  regional_zone_id              = module.cloudfront_static_web.cloudfront_hosted_zone_id
  acm_domain_validation_options = module.cloudfront_static_web-acm.domain_validation_options
}

// Validate SSL certificate
# resource "aws_acm_certificate_validation" "web_cert_validation" {
#   certificate_arn         = module.cloudfront_static_web-acm.cert_arn
#   validation_record_fqdns = module.route-53-web[0].acm_validation_record_fqdns
# }
