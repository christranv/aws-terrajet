variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "port" {
  type = number
}

variable "allocated_storage" {
  type = number
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "subnet_ids" {
  type = set(string)
}

variable "sg_ids" {
  type = set(string)
}
