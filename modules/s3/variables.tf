variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "is_destroy" {
  type    = bool
  default = false
}

variable "is_public" {
  type    = bool
  default = false
}

variable "enable_static_web" {
  type    = bool
  default = false
}

variable "enable_bucket_versioning" {
  type    = bool
  default = false
}

variable "init_folders" {
  type    = map(any)
  default = {}
}
