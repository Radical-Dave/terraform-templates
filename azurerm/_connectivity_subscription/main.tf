##
# Module to build the Azure DevOps Connectivity Subscription
##
locals {
  name                = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : ""), "/[^A-Za-z0-9]-/", ""))
  resource_group_name = lower(replace((length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg-${local.name}-core-${trimsuffix(var.location, "us")}"), "/[^A-Za-z0-9]-/", ""))
}
module "azurerm_resource_group" {
  source = "../azurerm_resource_group"
  name   = local.resource_group_name
}
module "azurerm_resource_group_mgmt" {
  source = "../azurerm_resource_group"
  name   = "${local.name}-mgmt-${var.location}"
}
module "azurerm_subnet_bastion" {
  source               = "../azurerm_subnet"
  address_prefixes     = ["172.24.11.128/28"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = module.azurerm_virtual_network.name
}
module "azurerm_virtual_network" {
  source              = "../azurerm_virtual_network"
  name                = "vnet-${trimprefix(local.resource_group_name, "rg-")}"
  location            = var.location
  resource_group_name = local.resource_group_name
}
module "azurerm_subnet" {
  source               = "../azurerm_subnet"
  address_prefixes     = ["172.24.11.144/28"]
  name                 = "vgw-${trimprefix(local.resource_group_name, "rg-")}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = module.azurerm_virtual_network.name
}
module "azurerm_storage_account" {
  source              = "../azurerm_storage_account"
  location            = var.location
  name                = "st${local.name}diag"
  resource_group_name = local.resource_group_name
}
module "azurerm_log_analytics_workspace" {
  source              = "../azurerm_log_analytics_workspace"
  name                = "log-${trimprefix(local.resource_group_name, "rg-")}"
  location            = var.location
  resource_group_name = local.resource_group_name
}