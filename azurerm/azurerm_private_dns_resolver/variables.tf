variable "name" {
  description = "The name of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "virtual_network_id" {
  description = "The virtual_network_id of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the azurerm_private_dns_resolver"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}