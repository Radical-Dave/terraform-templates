variable "appid" {
  description = "The appid of the resources"
  type        = string
  default     = "blueoftennessee"
}
variable "autostartwd" {
  description = "The autostartwd of the resources"
  type        = string
  default     = "n"
}
variable "autostopwd" {
  description = "The autostopwd of the resources"
  type        = string
  default     = "n"
}
variable "autostartsa" {
  description = "The autostartsa of the resources"
  type        = string
  default     = "n"
}
variable "autostopsa" {
  description = "The autostopsa of the resources"
  type        = string
  default     = "n"
}
variable "autostartsu" {
  description = "The autostartsu of the resources"
  type        = string
  default     = "n"
}
variable "autostopsu" {
  description = "The autostopsu of the resources"
  type        = string
  default     = "n"
}
variable "hostname" {
  description = "The hostname of the resources"
  type        = string
  default     = "n"
}
variable "terraform" {
  description = "The terraform of the resources / scriptname"
  type        = string
  default     = "y"
}
variable "cleardata" {
  description = "The cleardata of the resources - y, n, b"
  type        = string
  default     = "n"
}
variable "costcenter" {
  description = "The costcenter of the resources"
  type        = string
  default     = "5308"
}
variable "criticality" {
  description = "The criticality of the resources - secret, confidential, internal, public, internalprotected, externalprotected"
  type        = string
  default     = "medium"
}
variable "dataclass" {
  description = "The dataclass of the resources - low, medium, high, veryhigh"
  type        = string
  default     = "secret"
}
variable "description" {
  description = "The description of the resources"
  type        = string
  default     = "core"
}
variable "environment" {
  description = "The environment of the resource group"
  type        = string
  default     = "sbx"
}
variable "schdbypass" {
  description = "The schdbypass of the resources: n, a, y, pr"
  type        = string
  default     = "y"
}

variable "sla" {
  description = "The sla of the resources - tier1 - tier4"
  type        = string
  default     = "tier1"
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "backend_db" {
  description = "The backend_db of the resource group"
  type        = string
  default     = "{name}-backend-db"
}
variable "group" {
  description = "The group of the resources"
  type        = string
  default     = "DevOps"
}
variable "name" {
  description = "The name of the resources"
  type        = string
  default     = "connectivity"
}
variable "owner" {
  description = "The owner of the resources"
  type        = string
  default     = "joseph_rinckey"
}
variable "prefix" {
  description = "The prefix/department of the resources"
  type        = string
  default     = "io"
}
variable "resource_group_name" {
  description = "The resource_group_name defaults to rg-[name]-core-[location]"
  type        = string
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_egress_only_internet_gateway"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}