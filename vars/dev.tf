locals {
  dev = {
    project = "AWS Terraform"
    aws = {
      account_id = "" # AWS Account Id
      profile    = "aws-terraform-dev"
      region     = "ap-southeast-1"
    }
    network = {
      cidr_main     = "10.0.0.0/16"
      public_cidrs  = ["10.0.0.0/18", "10.0.64. 0/18"]
      private_cidrs = ["10.0.128.0/18", "10.0.192.0/18"]
      trust_ips     = []
    }
    ec2_sample = {
      availability_zone = "ap-southeast-1c"
      instance_type     = "t2.micro"
      ami               = "ami-0a8fdce33ca9cbe51"
      keypair_name      = "ec2-keypair"
    }
  }
}
