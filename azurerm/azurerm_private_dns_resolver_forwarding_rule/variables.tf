variable "domain_name" {
  description = "The domain_name of the azurerm_private_dns_resolver_forwarding_rule"
  type        = string
  default     = null
}
variable "enabled" {
  description = "The enabled of the azurerm_private_dns_resolver_forwarding_rule"
  type        = bool
  default     = true
}
variable "metadata" {
  description = "The metadata of the resource group of the azurerm_private_dns_resolver_forwarding_rule"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the azurerm_private_dns_resolver_forwarding_rule"
  type        = string
  default     = null
}
variable "target_dns_servers" {
  description = "The location of the azurerm_private_dns_resolver_forwarding_rule"
  type        = string
  default     = null
}
variable "dns_forwarding_ruleset_id" {
  description = "The dns_forwarding_ruleset_id of the azurerm_private_dns_resolver_forwarding_rule"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the azurerm_private_dns_resolver_forwarding_rule"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}