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
provider "aws" {
  profile = module.vars.env.aws_profile
  region  = module.vars.env.network.region

  default_tags {
    tags = {
      Project     = module.vars.env.project.name
      Environment = local.environment
    }
  }
}
