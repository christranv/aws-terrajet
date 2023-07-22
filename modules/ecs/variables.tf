variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "service_discovery_ns" {
  type = string
}

variable "amis" {
  description = "EC2 AMIs by region"
  default = {
    us-east-2      = "ami-0a2f86088203932e1"
    ap-southeast-1 = "ami-0e9b17c2a5411ea2f"
  }
}

variable "instance_type" {
  type = string
}

variable "keypair_name" {
  type = string
}

variable "sg_ids" {
  type = list(any)
}

variable "log_group" {
  type = string
}

variable "target_group_arns" {
  type = map(any)
}

variable "aws_iam_instance_profile" {
  type = string
}

variable "target_capacity" {
  type    = number
  default = 100
}

variable "autoscale_min" {
  type = number
}

variable "autoscale_max" {
  type = number
}

variable "autoscale_desired" {
  type        = number
  description = "Desired instances is decided by ASG capacity provider"
  default     = 1
}

variable "private_subnet_ids" {
  type = list(any)
}

variable "ecs_services" {
  type = map(any)
}

variable "scale_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "spot_price" {
  type = string
}

variable "repository_urls" {
  description = "ECR repository urls"
  type        = map(any)
}

variable "vpc_id" {
  type = string
}

variable "service_placement_constraints" {
  type    = list(any)
  default = []
}

variable "service_ordered_placement_strategies" {
  type = list(object({ type = string, field = string }))
}
