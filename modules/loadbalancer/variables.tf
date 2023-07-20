variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "is_internal" {
  type    = bool
  default = false
}

variable "vpc_id" {
  type = string
}

variable "subnets_ids" {
  type = list(string)
}

variable "listener_certificate_arn" {
  type = string
}

variable "hc_interval" {
  type    = number
  default = 5
}

variable "hc_timeout" {
  type    = number
  default = 5
}

variable "ecs_services" {
  type = map(any)
}
