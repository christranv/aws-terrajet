module "cloudfront_web_app_acm" {
  source      = "./modules/acm"
  project     = local.vars.project
  env         = local.environment
  domain_name = local.vars.route53.domain
  providers = {
    aws = aws.us-east-1
  }
}

module "cloudfront_web_app" {
  source                      = "./modules/cloudfront"
  project                     = local.vars.project
  env                         = local.environment
  domain                      = local.vars.route53.domain
  allow_domains               = [local.vars.route53.domain]
  cert_arn                    = module.cloudfront_web_app_acm.cert_arn
  enable_static_web           = true
  bucket_name                 = module.s3_web_app.bucket_name
  bucket_regional_domain_name = module.s3_web_app.bucket_regional_domain_name
  cache_ttl                   = 1209600 # 2 week
}
