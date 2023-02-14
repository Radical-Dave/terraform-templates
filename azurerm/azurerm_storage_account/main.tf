locals {
  name     = substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "st-${var.resource_group_name}" : "st-${var.resource_group_name}" : "st", "-", ""), 0, 24)
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
}
resource "azurerm_storage_account" "this" {
  name                     = substr(replace((startswith(local.name, "st") ? local.name : "st${local.name}"), "-", ""), 0, 24)
  location                 = local.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.sa_tier
  account_replication_type = var.sa_reptype
  tags                     = var.tags
}