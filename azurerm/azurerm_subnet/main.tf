locals {
  name                 = length(var.name != null ? var.name : "") > 0 ? var.name : trimprefix(replace(local.resource_group_name, "${var.environment}-${var.description}", "${var.environment}-snet-${var.description}"), "rg-")
  resource_group_name  = length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg-${trimprefix(var.name, "snet-")}"
  virtual_network_name = length(var.virtual_network_name != null ? var.virtual_network_name : "") > 0 ? var.virtual_network_name : "vnet-${trimprefix(var.resource_group_name, "rg-")}"
}
resource "azurerm_subnet" "this" {
  name                 = local.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = var.address_prefixes
}