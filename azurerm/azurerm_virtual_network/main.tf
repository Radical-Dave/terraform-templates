locals {
  name     = coalesce(var.name, length(coalesce(var.resource_group_name, "")) > 0 ? "vnet-${replace(var.resource_group_name, "rg-", "")}" : "vnet")
  location = coalesce(var.location, "eastus")
}
resource "azurerm_virtual_network" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}