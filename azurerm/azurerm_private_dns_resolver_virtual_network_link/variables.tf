variable "name" {
  description = "The name of the azurerm_private_dns_resolver_virtual_network_link"
  type        = string
  default     = null
}
variable "dns_forwarding_ruleset_id" {
  description = "The dns_forwarding_ruleset_id of the resource group"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "virtual_network_id" {
  description = "The virtual_network_id of the resource group of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}