variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "main_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "public_cidrs" {
  type = list(string)
}

variable "private_cidrs" {
  type = list(string)
}

variable "use_one_nat_gateway" {
  type    = bool
  default = true
}
