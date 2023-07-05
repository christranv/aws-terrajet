variable "project" {
  type = string
}
variable "env" {
  type = string
}
variable "name" {
  type = string
}

#########################
# Spot instance
#########################
variable "use_spot" {
  type        = bool
  description = "Create create spot instance instead of on-demand"
  default     = false
}
variable "spot_price" {
  type        = number
  description = "Required if use_spot=true"
  default     = 0
}
variable "region" {
  type        = string
  description = "Required if use_spot=true"
  default     = null
}
#########################
# End of Spot instance
#########################

variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "availability_zone" {
  type = string
}
variable "root_size" {
  type        = number
  description = "Root storage size"
  default     = null
}
variable "ebs_size" {
  type        = number
  description = "External storage size"
  default     = null
}
variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  default     = null
}
variable "user_data" {
  type        = any
  description = "Script to run when launching the instance"
  default     = null
}
variable "subnet_id" {
  type        = string
  description = "VPC Subnet ID to launch instance in"
  default     = null
}
variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with"
  default     = null
}
variable "assign_public_ip" {
  type        = bool
  description = "Create public ip for instance"
  default     = false
}
