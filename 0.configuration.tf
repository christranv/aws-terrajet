terraform {
  required_version = ">= 1.5.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}

provider "aws" {
  profile = local.vars.profile
  region  = local.vars.region

  default_tags {
    tags = {
      Project     = local.vars.project
      Environment = local.environment
    }
  }
}

# Only used to create ACM for cloudfront (because ACM and CloundFront use us-east-1 region)
provider "aws" {
  profile = local.vars.profile
  alias   = "us-east-1"
  region  = "us-east-1"
  default_tags {
    tags = {
      Project     = local.vars.project
      Environment = local.environment
    }
  }
}

locals {
  environment = lower(terraform.workspace)
  vars        = module.envs.env
}

module "envs" {
  source      = "./envs"
  environment = local.environment
}
