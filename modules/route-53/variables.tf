variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "domain_main" {
  type = string
}

# Alias record
variable "domain_name" {
  type = string
}

variable "regional_domain_name" {
  type = string
}

variable "regional_zone_id" {
  type = string
}

variable "acm_domain_validation_options" {
  type = any
}
