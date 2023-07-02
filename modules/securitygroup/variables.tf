variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_port_sg_targets" {
  type        = list(any)
  description = "Ingress rule for security group with single port"
  default     = []
}

variable "ingress_port_cidr_targets" {
  type        = list(any)
  description = "Ingress rule for CIDR blocks with single port"
  default     = []
}

variable "ingress_range_sg_targets" {
  type        = list(any)
  description = "Ingress rule for security group with port range"
  default     = []
}

variable "ingress_range_cidr_targets" {
  type        = list(any)
  description = "Ingress rule for CIDR blocks with port range"
  default     = []
}
