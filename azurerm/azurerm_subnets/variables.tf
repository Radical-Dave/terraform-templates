variable "description" {
  description = "The location of the resource group"
  type        = string
  default     = "core"
}
variable "environment" {
  description = "The environment of the resource group"
  type        = string
  default     = "sbx"
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
variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type        = any
}
variable "virtual_network_name" {
  description = "The virtual_network_name of the subnet"
  type        = string
  default     = null
}
variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type        = any
  /*
  #This implies a crash described here https://github.com/hashicorp/terraform/issues/22082 -->
  type = list(object({
    id            = string
    address_space = list(string)
    subnets       = any
    bastion       = bool
  }))
  */
}
variable "address_prefixes" {
  description = "The address_prefixes of the subnet"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}