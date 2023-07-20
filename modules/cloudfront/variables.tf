variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_regional_domain_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "cert_arn" {
  type        = string
  description = "ACM certificate arn"
}

variable "allow_domains" {
  type        = list(any)
  description = "Allow domains to access resource"
}

variable "enable_static_web" {
  type    = bool
  default = false
}

variable "cache_ttl" {
  type    = number
  default = 3600
}

/*
  Documents Signing Public Key for Signed-Url
*/

variable "enable_signed_url" {
  type    = bool
  default = false
}

variable "signed_urls_public_key" {
  type    = any
  default = null
}
