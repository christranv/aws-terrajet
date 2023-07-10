locals {
  dev = {
    project = "AWS Terraform Template"
    aws = {
      account_id = "084618547938" # AWS Account Id
      profile    = "aws-terraform-dev"
      region     = "ap-southeast-1"
    }
    network = {
      cidr_main     = "10.0.0.0/16"
      public_cidrs  = ["10.0.0.0/19", "10.0.32.0/19"]
      private_cidrs = ["10.0.128.0/19", "10.0.160.0/19"]
      trust_ips     = []
    }
    ec2_api = {
      availability_zone = "ap-southeast-1c"
      instance_type     = "t2.micro"
      ami               = "ami-0a8fdce33ca9cbe51"
      keypair_name      = "ec2-keypair"
    }
  }
}
