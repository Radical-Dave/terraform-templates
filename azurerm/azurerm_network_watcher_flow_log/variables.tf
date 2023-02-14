variable "enabled" {
  description = "The enabled of the azurerm_network_watcher_flow_log"
  type        = bool
  default     = true
}
variable "name" {
  description = "The name of the azurerm_network_watcher_flow_log"
  type        = string
}
variable "network_security_group_id" {
  description = "The network_security_group_id of the azurerm_network_watcher_flow_log"
  type        = string
}
variable "resource_group_name" {
  description = "The resource_group_name of the azurerm_network_watcher_flow_log"
  type        = string
}
variable "retention_policy_enabled" {
  description = "The retention_policy_enabled of the azurerm_network_watcher_flow_log"
  type        = bool
  default     = true
}
variable "retention_policy_days" {
  description = "The retention_policy_days of the azurerm_network_watcher_flow_log"
  type        = number
  default     = 90
}
variable "storage_account_id" {
  description = "The storage_account_id of the azurerm_network_watcher_flow_log"
  type        = string
}
variable "tags" {
  description = "Tags for the azurerm_network_watcher_flow_log"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}
variable "traffic_analytics_enabled" {
  description = "The traffic_analytics_enabled of the azurerm_network_watcher_flow_log"
  type        = bool
  default     = true
}
variable "traffic_analytics_interval" {
  description = "The traffic_analytics_interval of the azurerm_network_watcher_flow_log"
  type        = number
  default     = 10
}
variable "traffic_analytics_workspace_id" {
  description = "The traffic_analytics_workspace_id of the azurerm_network_watcher_flow_log"
  type        = string
  default     = null
}
variable "traffic_analytics_workspace_region" {
  description = "The traffic_analytics_region of the azurerm_network_watcher_flow_log"
  type        = string
  default     = null
}
variable "traffic_analytics_workspace_resource_id" {
  description = "The traffic_analytics_workspace_resource_id of the azurerm_network_watcher_flow_log"
  type        = string
  default     = null
}