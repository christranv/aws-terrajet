variable "project" {
  type        = string
  description = "project name"
}
variable "env" {
  type        = string
  description = "environment"
}
variable "name" {
  type        = string
  description = "name to be used on EC2 instance created"
}

#########################
# Spot instance
#########################
variable "is_spot" {
  type        = bool
  description = "weather to create spot instance instead of on-demand"
  default     = false
}
variable "spot_price" {
  type        = number
  description = "Required when is_spot=true"
  default     = 0
}
variable "region" {
  type        = string
  description = "Required when is_spot=true"
  default     = null
}
#########################
# End of Spot instance
#########################

variable "ami" {
  type        = string
  description = "id of AMI to use for the instance"
}
variable "instance_type" {
  type        = string
  description = "the type of instance to start"
}
variable "availability_zone" {
  type        = string
  description = "az to start the instance in"
}
variable "root_size" {
  type        = number
  description = "root storage size"
  default     = null
}
variable "ebs_size" {
  type        = number
  description = "external storage size"
  default     = null
}
variable "key_name" {
  type        = string
  description = "key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  default     = null
}
variable "user_data" {
  type        = any
  description = "user data to provide when launching the instance"
  default     = null
}
variable "subnet_id" {
  type        = string
  description = "the VPC Subnet ID to launch in"
  default     = null
}
variable "vpc_security_group_ids" {
  type        = list(string)
  description = "a list of security group IDs to associate with"
  default     = null
}
variable "assign_public_ip" {
  type        = bool
  description = "create public ip for instance"
  default     = false
}
