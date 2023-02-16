##
# Module to build the Azure DevOps Identity Subscription
##
locals {
  name                = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : ""), "/[^A-Za-z0-9]-/", ""))
  resource_group_name = lower(replace((length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg-${length(var.prefix) > 0 ? "${var.prefix}-" : ""}${local.name}-${var.environment}-${var.description}-${var.location}-1"), "/[^A-Za-z0-9]-/", ""))
  tagset = {
    costcenter  = var.costcenter,
    environmnet = var.environment,
    appid       = var.appid,
    owner       = var.owner,
    department  = var.prefix,
    terraform   = var.terraform,
    cleardata   = var.cleardata
  }
}
module "azurerm_resource_group" {
  source = "../azurerm_resource_group"
  name   = local.resource_group_name
  tags   = local.tagset
}
module "azurerm_resource_group_mgmt" {
  source = "../azurerm_resource_group"
  name   = replace(local.resource_group_name, var.description, "mgmt")
  tags   = local.tagset
}
module "azurerm_storage_account" {
  depends_on          = [module.azurerm_resource_group_mgmt]
  source              = "../azurerm_storage_account"
  location            = var.location
  name                = "st${replace(trimprefix(local.name, "rg-"), "identity", "identitydiag")}"
  resource_group_name = module.azurerm_resource_group_mgmt.name
  tags                = local.tagset
}
module "azurerm_log_analytics_workspace" {
  depends_on          = [module.azurerm_resource_group_mgmt]
  source              = "../azurerm_log_analytics_workspace"
  name                = trimprefix(replace(module.azurerm_resource_group_mgmt.name, "${var.environment}-${var.description}", "${var.environment}-log-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group_mgmt.name
  tags                = local.tagset
}
module "azurerm_virtual_network" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../azurerm_virtual_network"
  address_space       = ["172.24.11.160/27"]
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-vnw-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
module "azurerm_subnet_in" {
  depends_on           = [module.azurerm_resource_group]
  source               = "../azurerm_subnet"
  name                 = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-sub-dns-in-${var.description}"), "rg-")
  address_prefixes     = ["172.24.11.160/28"]
  resource_group_name  = module.azurerm_resource_group.name
  virtual_network_name = module.azurerm_virtual_network.name
  tags                 = local.tagset
}
module "azurerm_subnet_out" {
  depends_on           = [module.azurerm_resource_group]
  source               = "../azurerm_subnet"
  name                 = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-sub-dns-out-${var.description}"), "rg-")
  address_prefixes     = ["172.24.11.176/28"]
  resource_group_name  = module.azurerm_resource_group.name
  virtual_network_name = module.azurerm_virtual_network.name
  tags                 = local.tagset
}
module "azurerm_private_dns_resolver" {
  depends_on          = [module.azurerm_resource_group, module.azurerm_virtual_network]
  source              = "../azurerm_private_dns_resolver"
  location            = var.location
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-dnr-${var.description}"), "rg-")
  resource_group_name = module.azurerm_resource_group.name
  virtual_network_id  = module.azurerm_virtual_network.id
  tags                = local.tagset
}
module "azurerm_private_dns_zone" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../azurerm_private_dns_zone"
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-dnz-${var.description}"), "rg-")
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
module "azurerm_private_dns_resolver_outbound_endpoint" {
  depends_on              = [module.azurerm_resource_group, module.azurerm_private_dns_resolver, module.azurerm_subnet_in]
  source                  = "../azurerm_private_dns_resolver_outbound_endpoint"
  location                = var.location
  name                    = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-poe-${var.description}"), "rg-")
  private_dns_resolver_id = module.azurerm_private_dns_resolver.id
  resource_group_name     = module.azurerm_resource_group.name
  subnet_id               = module.azurerm_subnet_out.id
  tags                    = local.tagset
}
module "azurerm_private_dns_resolver_dns_forwarding_ruleset" {
  depends_on                                 = [module.azurerm_resource_group, module.azurerm_private_dns_resolver_outbound_endpoint]
  source                                     = "../azurerm_private_dns_resolver_dns_forwarding_ruleset"
  location                                   = var.location
  name                                       = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-prs-${var.description}"), "rg-")
  private_dns_resolver_outbound_endpoint_ids = [module.azurerm_private_dns_resolver_outbound_endpoint.id]
  resource_group_name                        = module.azurerm_resource_group.name
  tags                                       = local.tagset
}
module "azurerm_private_dns_resolver_virtual_network_link" {
  depends_on                = [module.azurerm_resource_group, module.azurerm_private_dns_resolver_dns_forwarding_ruleset, module.azurerm_virtual_network.id]
  source                    = "../azurerm_private_dns_resolver_virtual_network_link"
  dns_forwarding_ruleset_id = module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id
  name                      = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-vnl-${var.description}"), "rg-")
  resource_group_name       = module.azurerm_resource_group.name
  virtual_network_id        = module.azurerm_virtual_network.id
}
module "azurerm_private_dns_resolver_forwarding_rule" {
  depends_on                = [module.azurerm_resource_group, module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id]
  source                    = "../azurerm_private_dns_resolver_forwarding_rule"
  dns_forwarding_ruleset_id = module.azurerm_private_dns_resolver_dns_forwarding_ruleset.id
  domain_name               = var.domain_name
  name                      = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-pfr-${var.description}"), "rg-")
  tags                      = local.tagset
}
module "azurerm_private_dns_resolver_inbound_endpoint" {
  depends_on              = [module.azurerm_resource_group, module.azurerm_private_dns_resolver.id, module.azurerm_subnet_in]
  source                  = "../azurerm_private_dns_resolver_inbound_endpoint"
  name                    = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-pie-${var.description}"), "rg-")
  private_dns_resolver_id = module.azurerm_private_dns_resolver.id
  location                = var.location
  resource_group_name     = module.azurerm_resource_group.name
  subnet_id               = module.azurerm_subnet_in.id
  tags                    = local.tagset
}
module "azurerm_network_security_group" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../azurerm_network_security_group"
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-nsg-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
module "azurerm_subnet_network_security_group_association" {
  depends_on                = [module.azurerm_resource_group, module.azurerm_network_security_group, module.azurerm_subnet_in]
  source                    = "../azurerm_subnet_network_security_group_association"
  network_security_group_id = module.azurerm_network_security_group.id
  subnet_id                 = module.azurerm_subnet_in.id
}
module "azurerm_network_watcher" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../azurerm_network_watcher"
  description         = var.description
  environment         = var.environment
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-nw-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
#module "azurerm_network_watcher_flow_log" {
#  depends_on                              = [module.azurerm_resource_group, module.azurerm_storage_account.id, module.azurerm_network_security_group.id]
#  source                                  = "../azurerm_network_watcher_flow_log"
#  description                             = var.description
#  environment                             = var.environment
#  name                                    = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-nwf-${var.description}"), "rg-")
#  network_security_group_id               = module.azurerm_network_security_group.id
#  network_watcher_name                    = module.azurerm_network_watcher.name
#  resource_group_name                     = module.azurerm_resource_group.name
#  storage_account_id                      = module.azurerm_storage_account.id
#  traffic_analytics_workspace_id          = module.azurerm_log_analytics_workspace.workspace_id
#  traffic_analytics_workspace_region      = module.azurerm_log_analytics_workspace.location
#  traffic_analytics_workspace_resource_id = module.azurerm_log_analytics_workspace.id
#  tags = local.tagset
#}