##
# Module to build the Azure DevOps Identity Subscription
##
locals {
  name                = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : ""), "/[^A-Za-z0-9]-/", ""))
  resource_group_name = lower(replace((length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg-${local.name}-core-${trimsuffix(var.location, "us")}"), "/[^A-Za-z0-9]-/", ""))
}
module "azurerm_resource_group_mgmt" {
  source = "../azurerm_resource_group"
  name   = "rg-${local.name}-mgmt-${var.location}"
}
module "azurerm_storage_account" {
  source              = "../azurerm_storage_account"
  location            = var.location
  name                = "st${replace(trimprefix(local.name, "rg-"), "core", "diag")}"
  resource_group_name = local.resource_group_name
}
module "azurerm_log_analytics_workspace" {
  source              = "../azurerm_log_analytics_workspace"
  name                = "log-${trimprefix(local.resource_group_name, "rg-")}"
  location            = var.location
  resource_group_name = local.resource_group_name
}
module "azurerm_resource_group" {
  source = "../azurerm_resource_group"
  name   = replace(local.resource_group_name, "mgmt", "core")
}
module "azurerm_virtual_network" {
  source              = "../azurerm_virtual_network"
  address_space       = ["172.24.11.160/27"]
  name                = "vnet-${trimprefix(local.resource_group_name, "rg-")}"
  location            = var.location
  resource_group_name = local.resource_group_name
}
module "azurerm_subnet" {
  source               = "../azurerm_subnet"
  name                 = "snet-${trimprefix(local.resource_group_name, "rg-")}"
  address_prefixes     = ["172.24.11.160/28"]
  resource_group_name  = local.resource_group_name
  virtual_network_name = module.azurerm_virtual_network.name
}
module "azurerm_private_dns_resolver" {
  depends_on          = [module.azurerm_virtual_network.id]
  source              = "../azurerm_private_dns_resolver"
  location            = var.location
  name                = "pdnr-${trimprefix(local.resource_group_name, "rg-")}"
  resource_group_name = local.resource_group_name
  virtual_network_id  = module.azurerm_virtual_network.id
}
module "azurerm_private_dns_zone" {
  source              = "../azurerm_private_dns_zone"
  name                = "pdns-${trimprefix(local.resource_group_name, "rg-")}"
  resource_group_name = local.resource_group_name
}
module "azurerm_private_dns_resolver_outbound_endpoint" {
  depends_on              = [module.azurerm_private_dns_resolver.id, module.azurerm_subnet.id]
  source                  = "../azurerm_private_dns_resolver_outbound_endpoint"
  location                = var.location
  name                    = "pdno-${trimprefix(local.resource_group_name, "rg-")}"
  private_dns_resolver_id = module.azurerm_private_dns_resolver.id
  resource_group_name     = local.resource_group_name
  subnet_id               = module.azurerm_subnet.id
}
module "azurerm_private_dns_resolver_dns_forwarding_ruleset" {
  depends_on                                 = [module.azurerm_private_dns_resolver_outbound_endpoint.id]
  source                                     = "../azurerm_private_dns_resolver_dns_forwarding_ruleset"
  location                                   = var.location
  name                                       = local.name
  private_dns_resolver_outbound_endpoint_ids = [module.azurerm_private_dns_resolver_outbound_endpoint.id]
  resource_group_name                        = local.resource_group_name
}
module "azurerm_private_dns_resolver_virtual_network_link" {
  depends_on                = [module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id, module.azurerm_virtual_network.id]
  source                    = "../azurerm_private_dns_resolver_virtual_network_link"
  dns_forwarding_ruleset_id = module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id
  name                      = local.name
  resource_group_name       = local.resource_group_name
  virtual_network_id        = module.azurerm_virtual_network.id
}
module "azurerm_private_dns_resolver_forwarding_rule" {
  depends_on                = [module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id]
  source                    = "../azurerm_private_dns_resolver_forwarding_rule"
  dns_forwarding_ruleset_id = module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id
  domain_name               = var.domain_name
  name                      = local.name
}
module "azurerm_private_dns_resolver_inbound_endpoint" {
  depends_on              = [module.azurerm_private_dns_resolver.id, module.azurerm_subnet.id]
  source                  = "../azurerm_private_dns_resolver_inbound_endpoint"
  name                    = "io-dnsresolver"
  private_dns_resolver_id = module.azurerm_private_dns_resolver.id
  location                = var.location
  resource_group_name     = local.resource_group_name
  subnet_id               = module.azurerm_subnet.id
  tags                    = var.tags
}