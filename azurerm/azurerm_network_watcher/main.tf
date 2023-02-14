locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "azurerm_network_watcher" "this" {
  name                = can(regex("^rg-", local.name)) ? local.name : "rg-${local.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}