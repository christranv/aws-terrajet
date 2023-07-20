variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_port_sg_targets" {
  type        = list(any)
  description = "Ingress  single port rule for security group target"
  default     = []
}

variable "ingress_port_cidr_targets" {
  type        = list(any)
  description = "Ingress single port rule for CIDR block target"
  default     = []
}

variable "ingress_range_sg_targets" {
  type        = list(any)
  description = "Ingress port range rule for security group target"
  default     = []
}

variable "ingress_range_cidr_targets" {
  type        = list(any)
  description = "Ingress port range rule for CIDR block target"
  default     = []
}
