output "api_domain" {
  value = module.route53_record_api.name
}

output "db_domain" {
  value = module.rds_db.endpoint
}
