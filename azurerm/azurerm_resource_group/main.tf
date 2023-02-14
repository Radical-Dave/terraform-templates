locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "azurerm_resource_group" "this" {
  name     = can(regex("^rg-", local.name)) ? local.name : "rg-${local.name}"
  location = var.location
  tags     = var.tags
}