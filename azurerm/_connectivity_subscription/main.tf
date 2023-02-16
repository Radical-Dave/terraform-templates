##
# Module to build the Azure DevOps Connectivity Subscription
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
  source     = "../azurerm_resource_group"
  name       = replace(local.resource_group_name, var.description, "mgmt")
  tags       = local.tagset
}
module "azurerm_subnet_bastion" {
  depends_on           = [module.azurerm_resource_group.name]
  source               = "../azurerm_subnet"
  address_prefixes     = ["172.24.11.128/28"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.resource_group_name
  virtual_network_name = module.azurerm_virtual_network.name
  tags                 = local.tagset
}
module "azurerm_virtual_network" {
  depends_on          = [module.azurerm_resource_group.name]
  source              = "../azurerm_virtual_network"
  address_space       = ["172.24.11.128/27"]
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-vnw-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.resource_group_name
  tags                = local.tagset
}
module "azurerm_subnet" {
  depends_on           = [module.azurerm_resource_group.name]
  source               = "../azurerm_subnet"
  address_prefixes     = ["172.24.11.144/28"]
  name                 = "GatewaySubnet"
  resource_group_name  = module.azurerm_resource_group.name
  virtual_network_name = module.azurerm_virtual_network.name
  tags                 = local.tagset
}
#module "azurerm_public_ip" {
#  source              = "../azurerm_public_ip"
#  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-pip-${var.description}"), "rg-")
#  location            = var.location
#  resource_group_name = local.resource_group_name
#  tags = local.tagset
#}
#module "azurerm_virtual_network_gateway" {
#  source               = "../azurerm_virtual_network_gateway"
#  name                 = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-vgw-${var.description}"), "rg-")
#  public_ip_address_id = module.azurerm_public_ip.id
#  resource_group_name  = module.resource_group_name
#  subnet_id            = module.azurerm_subnet.id
#  tags = local.tagset
#}
module "azurerm_storage_account" {
  depends_on                 = [module.azurerm_resource_group_mgmt.name, module.azurerm_subnet.id]
  source                     = "../azurerm_storage_account"
  location                   = var.location
  name                       = "st${replace(trimprefix(local.name, "rg-"), "core", "diag")}"
  resource_group_name        = module.azurerm_resource_group_mgmt.name
  virtual_network_subnet_ids = toset([module.azurerm_subnet.id])
  tags                       = local.tagset
}
module "azurerm_log_analytics_workspace" {
  depends_on          = [module.azurerm_resource_group_mgmt.name]
  source              = "../azurerm_log_analytics_workspace"
  name                = trimprefix(replace(module.azurerm_resource_group_mgmt.name, "${var.environment}-${var.description}", "${var.environment}-log-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group_mgmt.name
  tags                = local.tagset
}
module "azurerm_network_security_group" {
  depends_on          = [module.azurerm_resource_group.name]
  source              = "../azurerm_network_security_group"
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-nsg-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
module "azurerm_subnet_network_security_group_association" {
  depends_on                = [module.azurerm_network_security_group.id, module.azurerm_subnet.id]
  source                    = "../azurerm_subnet_network_security_group_association"
  network_security_group_id = module.azurerm_network_security_group.id
  subnet_id                 = module.azurerm_subnet.id
}
module "azurerm_network_watcher" {
  depends_on          = [module.azurerm_resource_group.name]
  source              = "../azurerm_network_watcher"
  description         = var.description
  environment         = var.environment
  name                = trimprefix(replace(module.azurerm_resource_group.name, "${var.environment}-${var.description}", "${var.environment}-nw-${var.description}"), "rg-")
  location            = var.location
  resource_group_name = module.azurerm_resource_group.name
  tags                = local.tagset
}
#module "azurerm_network_watcher_flow_log" {
#  depends_on                              = [module.azurerm_resource_group.name, module.azurerm_storage_account.id, module.azurerm_network_security_group.id]
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