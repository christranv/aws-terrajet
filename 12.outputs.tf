output "route_53_ns" {
  value = module.route53_main.name_servers
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "s3_web_app_bucket_name" {
  value = module.s3_web_app.bucket_name
}

output "api_domain" {
  value = module.route53_record_api.name
}

output "db_endpoint" {
  value = module.rds_db.endpoint
}

output "bastion_ip" {
  value = module.ec2_bastion.public_dns
}
