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
  type        = list(object({ port : number, protocol : string, security_group_id : string }))
  description = "Ingress  single port rule for security group target"
  default     = []
}

variable "ingress_port_cidr_targets" {
  type        = list(object({ port : number, protocol : string, cidr_blocks : list(string) }))
  description = "Ingress single port rule for CIDR block target"
  default     = []
}

variable "ingress_range_sg_targets" {
  type        = list(object({ from_port : number, to_port : number, protocol : string, security_group_id : string }))
  description = "Ingress port range rule for security group target"
  default     = []
}

variable "ingress_range_cidr_targets" {
  type        = list(object({ from_port : number, to_port : number, protocol : string, cidr_blocks : list(string) }))
  description = "Ingress port range rule for CIDR block target"
  default     = []
}
