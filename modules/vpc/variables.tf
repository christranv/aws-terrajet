variable "main_cidr" {
  type        = string
  description = "main vpc cidr"
}

variable "region" {
  type        = string
  description = "region"
}

variable "project" {
  type        = string
  description = "project name"
}

variable "env" {
  type        = string
  description = "deploy environment"
}

variable "public_cidrs" {
  type        = list(string)
  description = "public subnet"
}

variable "private_cidrs" {
  type        = list(string)
  description = "private subnet"
}

variable "only_one_nat_gateway" {
  type        = bool
  default     = true
  description = "create one nat gateway"
}





