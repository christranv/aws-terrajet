variable "hosted_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "type" {
  type    = string
  default = "A"
}

variable "useAlias" {
  type    = bool
  default = true
}

variable "alias" {
  default = []
}

variable "ttl" {
  type    = number
  default = 60
}

variable "records" {
  type    = set(string)
  default = null
}
