locals {
  name                = coalesce(var.name, length(coalesce(var.resource_group_name, "")) > 0 ? "vnet-${replace(var.resource_group_name, "rg-", "")}" : "vnet")
  resource_group_name = lower(replace((length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg--io-${local.name}-${var.location}-1"), "/[^A-Za-z0-9]-/", ""))
}
resource "azurerm_virtual_network_gateway" "this" {
  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.subnet_id
  }
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags
  type                = var.type
}