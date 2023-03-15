locals {
  name                 = length(var.name != null ? var.name : "") > 0 ? var.name : trimprefix(replace(local.resource_group_name, "${var.environment}-${var.description}", "${var.environment}-snet-${var.description}"), "rg-")
  resource_group_name  = length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "rg-${trimprefix(var.name, "snet-")}"
  virtual_network_name = length(var.virtual_network_name != null ? var.virtual_network_name : "") > 0 ? var.virtual_network_name : "vnet-${trimprefix(var.resource_group_name, "rg-")}"
}
resource "azurerm_subnet" "this" {
  for_each                                       = var.subnets
    name = length(each.value["name"] != null ? each.value["name"] : "") > 0 ? each.value["name"] : trimprefix(replace(local.resource_group_name, "${var.environment}-${var.description}", "${var.environment}-snet-${var.description}"), "rg-")
   # name                                           = each.value["name"]
  #resource_group_name                            = data.azurerm_resource_group.network.name
  address_prefixes                                 = each.value["address_prefixes"]
  resource_group_name  = var.resource_group_name
  service_endpoints                              = lookup(each.value, "service_endpoints", null)
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", null) #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Default valule is false. Conflicts with enforce_private_link_service_network_policies.
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", null)  #(Optional) Enable or Disable network policies for the private link service on the subnet. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies.
  /*
  This forces a destroy when adding a new vnet --> 
  virtual_network_name      = lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]
  Workaround -->
  */
  #depends_on           = [azurerm_virtual_network.vnets]
  virtual_network_name = "${var.net_prefix}-${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["prefix"]}-vnet${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["id"]}"

  #name                 = local.name
  #resource_group_name  = var.resource_group_name
  #virtual_network_name = local.virtual_network_name
  #address_prefixes     = var.address_prefixes
  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", [])
    content {
      name = lookup(delegation.value, "name", null)
      dynamic "service_delegation" {
        for_each = lookup(delegation.value, "service_delegation", [])
        content {
          name    = lookup(service_delegation.value, "name", null)    # (Required) The name of service to delegate to. Possible values include Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.Databricks/workspaces, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Logic/integrationServiceEnvironments, Microsoft.Netapp/volumes, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.Web/hostingEnvironments and Microsoft.Web/serverFarms.
          actions = lookup(service_delegation.value, "actions", null) # (Required) A list of Actions which should be delegated. Possible values include Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action, Microsoft.Network/virtualNetworks/subnets/action and Microsoft.Network/virtualNetworks/subnets/join/action.
        }
      }
    }
  }
}