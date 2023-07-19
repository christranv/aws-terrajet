variable "project" {
  type = string
}

variable "env" {
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

variable "sg_ids" {
  type = list(string)
}

variable "port" {
  type = number
}

variable "allocated_storage" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}
