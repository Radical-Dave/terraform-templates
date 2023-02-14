locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = local.name
  location                = var.location
  private_dns_resolver_id = var.private_dns_resolver_id
  subnet_id               = var.subnet_id
  tags                    = var.tags
}