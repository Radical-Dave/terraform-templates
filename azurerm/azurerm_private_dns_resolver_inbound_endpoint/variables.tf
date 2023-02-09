variable "name" {
  description = "The name of the azurerm_private_dns_resolver_inbound_endpoint"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azurerm_private_dns_resolver_inbound_endpoint"
  type        = string
  default     = null
}
variable "private_dns_resolver_id" {
  description = "The private_dns_resolver_id of the azurerm_private_dns_resolver_inbound_endpoint"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group of the azurerm_private_dns_resolver"
  type        = string
  default     = null
}
variable "subnet_id" {
  description = "The subnet_id of the azurerm_private_dns_resolver_inbound_endpoint"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the azurerm_private_dns_resolver_inbound_endpoint"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}