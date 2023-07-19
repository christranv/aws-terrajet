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
  profile = module.vars.env.aws_profile
  region  = module.vars.env.network.region

  default_tags {
    tags = {
      Project     = module.vars.env.project.name
      Environment = local.environment
    }
  }
}

# Only used to create ACM for cloudfront (because ACM and CloundFront use us-east-1 region)
provider "aws" {
  profile = module.vars.env.aws_profile
  alias   = "us-east-1"
  region  = "us-east-1"
  default_tags {
    tags = {
      Project     = module.vars.env.project.name
      Environment = local.environment
    }
  }
}

locals {
  environment = lower(terraform.workspace)
  trust_ips   = module.vars.env.network.trust_ips
}

module "vars" {
  source      = "./vars"
  environment = locals.environment
}
