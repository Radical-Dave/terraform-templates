locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "pdnr-${trimprefix(var.resource_group_name, "rg-")}"
}
resource "azurerm_private_dns_resolver" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = var.tags
}