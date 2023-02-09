variable "name" {
  description = "The name of the azurerm_private_dns_resolver_dns_forwarding_ruleset"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azurerm_private_dns_resolver_dns_forwarding_ruleset"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group of the azurerm_private_dns_resolver_dns_forwarding_ruleset"
  type        = string
  default     = null
}
variable "private_dns_resolver_outbound_endpoint_ids" {
  description = "The private_dns_resolver_outbound_endpoint_ids of the azurerm_private_dns_resolver_dns_forwarding_ruleset"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Tags for the azurerm_private_dns_resolver_dns_forwarding_ruleset"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}