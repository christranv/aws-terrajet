module "cloudfront_static_web_acm" {
  source        = "./modules/acm"
  project       = module.vars.env.project.name
  env           = local.environment
  domain_main   = module.vars.env.network.domains.web
  is_import_ssl = false
  providers = {
    aws = aws.us-east-1
  }
}

module "cloudfront_static_web" {
  source                      = "./modules/cloudfront"
  project                     = module.vars.env.project.name
  env                         = local.environment
  domain                      = module.vars.env.network.domains.web
  allow_domains               = [module.vars.env.network.domains.web]
  cert_arn                    = module.cloudfront_static_web_acm.cert_arn
  enable_static_web           = true
  bucket_name                 = module.s3_static_web_app.bucket_name
  bucket_regional_domain_name = module.s3_static_web_app.bucket_regional_domain_name
  cache_ttl                   = 1209600 # 2 week
}
