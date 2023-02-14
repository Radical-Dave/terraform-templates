locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "azurerm_network_watcher_flow_log" "this" {
  enabled                   = var.enabled
  network_security_group_id = var.network_security_group_id
  network_watcher_name      = can(regex("^rg-", local.name)) ? local.name : "rg-${local.name}"
  resource_group_name       = var.resource_group_name
  retention_policy {
    enabled = var.retention_policy_enabled
    days    = var.retention_policy_days
  }
  storage_account_id = var.storage_account_id
  tags               = var.tags
  traffic_analytics {
    enabled               = var.traffic_analytics_enabled
    workspace_id          = var.traffic_analytics_workspace_id
    workspace_region      = var.traffic_analytics_workspace_region
    workspace_resource_id = var.traffic_analytics_workspace_resource_id
    interval_in_minutes   = var.traffic_analytics_interval
  }
}