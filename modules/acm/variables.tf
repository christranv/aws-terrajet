variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "domain_main" {
  type = string
}

variable "region" {
  type = string
}

variable "is_import_ssl" {
  type        = bool
  description = "If import SSL from local machine"
  default     = false
}





