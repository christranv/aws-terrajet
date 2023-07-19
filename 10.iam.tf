###################
# CI/CD user for deployment
###################
module "cicd_user_policy" {
  source                  = "./modules/policy/user-policy/cicd"
  project                 = module.vars.env.project.name
  env                     = local.environment
  region                  = module.vars.env.network.region
  account_id              = module.vars.env.account_id
  web_app_bucket_name     = module.s3-static-web-app.bucket_name
  web_app_distribution_id = module.cloudfront-static-web.cloudfront_id
  ecs_cluster_name        = module.ecs_cluster.cluster_name
}

module "cicd_user" {
  source          = "./modules/iam/user"
  username        = module.vars.env.users.cicd
  policy_arn      = module.cicd_user_policy.arn
  enable_password = false
}
