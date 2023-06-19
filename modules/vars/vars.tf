locals {
  environments = {
    "dev" : local.dev,
    "qa" : local.qa,
    "staging" : local.staging,
    "prod" : local.prod
  }
}
