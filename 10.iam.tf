###################
# CI/CD user for deployment
###################
module "cicd_user_policy" {
  source                  = "./modules/policy/user-policy/cicd"
  project                 = local.vars.project
  env                     = local.environment
  region                  = local.vars.region
  account_id              = local.vars.account_id
  web_app_bucket_name     = module.s3_web_app.bucket_name
  web_app_distribution_id = module.cloudfront_web_app.cloudfront_id
  ecs_cluster_name        = module.ecs_cluster.cluster_name
}

module "cicd_user" {
  source     = "./modules/iam/user"
  username   = "${local.vars.project}-${local.environment}-cicd-user"
  policy_arn = module.cicd_user_policy.arn
}
