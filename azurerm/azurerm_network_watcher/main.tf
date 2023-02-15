locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = length(var.name) > 0 ? var.name : length(var.resource_group_name) > 0 ? trimprefix(replace(var.resource_group_name, "${var.environment}-${var.description}", "${var.environment}-nw-${var.description}"), "rg-") : "nw-1"
}
resource "azurerm_network_watcher" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}