locals {
  name     = substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "st-${var.resource_group_name}" : "st-${var.resource_group_name}" : "st", "-", ""), 0, 24)
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
}
resource "azurerm_storage_account" "this" {
  name                            = substr(replace(local.name, "-", ""), 0, 24)
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  location                        = local.location
  public_network_access_enabled   = var.public_network_access_enabled
  resource_group_name             = var.resource_group_name
  tags                            = var.tags
  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }
}