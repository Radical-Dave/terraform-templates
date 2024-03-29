variable "delegations" {
  description = "The delegations of the subnet."
  type        = any
  default     = null
}
variable "description" {
  description = "The location of the subnet"
  type        = string
  default     = "core"
}
variable "environment" {
  description = "The environment of the subnet"
  type        = string
  default     = "main"
}
variable "location" {
  description = "The location of the subnet"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the subnet"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "virtual_network_name" {
  description = "The virtual_network_name of the subnet"
  type        = string
  default     = null
}
variable "address_prefixes" {
  description = "The address_prefixes of the subnet"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Tags for the subnet"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}