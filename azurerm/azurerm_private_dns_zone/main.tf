locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_private_dns_zone" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
}