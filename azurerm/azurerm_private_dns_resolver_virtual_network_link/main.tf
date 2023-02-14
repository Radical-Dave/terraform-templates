locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_private_dns_resolver_virtual_network_link" "this" {
  name                      = local.name
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  virtual_network_id        = var.virtual_network_id
}