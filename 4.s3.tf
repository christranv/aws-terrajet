module "s3_web_app" {
  source            = "./modules/s3"
  project           = local.vars.project
  env               = local.environment
  name              = "static-web-app"
  is_public         = false
  is_destroy        = false
  enable_static_web = true
  init_folders = {
    root = {
      localBasePath = "assets/s3-static-web-app"
      s3BasePath    = "/"
    }
  }
}

module "s3_web_app_policy" {
  source             = "./modules/policy/s3-bucket-policy"
  account_id         = local.vars.account_id
  bucket_name        = module.s3_web_app.bucket_name
  cloudfront_dist_id = module.cloudfront_web_app.id
}
