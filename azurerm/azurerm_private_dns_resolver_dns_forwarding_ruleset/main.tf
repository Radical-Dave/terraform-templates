locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  location                                   = var.location
  name                                       = local.name
  resource_group_name                        = var.resource_group_name
  private_dns_resolver_outbound_endpoint_ids = var.private_dns_resolver_outbound_endpoint_ids
  tags                                       = var.tags
}