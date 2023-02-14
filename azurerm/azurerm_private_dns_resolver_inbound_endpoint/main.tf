locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name = local.name
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.subnet_id
  }
  location                = var.location
  private_dns_resolver_id = var.private_dns_resolver_id
  tags                    = var.tags

}