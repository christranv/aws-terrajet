module "s3_web_app" {
  source            = "./modules/s3"
  project           = module.vars.env.project.name
  env               = local.environment
  name              = "static-web-app"
  is_public         = false
  is_destroy        = false
  enable_static_web = true
  init_folders = {
    root = {
      localBasePath = "assets/s3-static-web-app"
      s3BasePath    = "/"
      acl           = "public-read"
    }
  }
}

module "s3_web_app_policy" {
  source             = "./modules/policy/s3-bucket-policy"
  account_id         = module.vars.env.account_id
  bucket_name        = module.s3_web_app.bucket_name
  cloudfront_dist_id = module.cloudfront_web_app.cloudfront_id
}
