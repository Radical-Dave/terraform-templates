locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "log-${trimprefix(var.resource_group_name,"rg-")}"
}
resource "azurerm_log_analytics_workspace" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}