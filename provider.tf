###################
# General Initialization
###################
terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.55.0"
    }
  }
}

# Configure the AWS Provider
# Notice if AWS_ACCESS_KEY is null, get from local AWS credentails file
provider "aws" {
  profile    = var.AWS_ACCESS_KEY == null ? module.vars.env.network.aws_profile : null
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = module.vars.env.network.region

  default_tags {
    tags = {
      Project     = module.vars.env.project.name
      Environment = local.environment
    }
  }
}

data "aws_caller_identity" "current" {}

# Configure the SOPS Provider
provider "sops" {
}
data "sops_file" "secret_variables" {
  source_file = "./sops/secrets.${local.environment}.yaml"
}
