variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "ecs_services" {
  type = map(any)
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "keep_last" {
  type        = string
  description = "Number of latest images to be kept"
  default     = 3
}
