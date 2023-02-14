output "id" {
  description = "The id of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.id
}
output "location" {
  description = "The location of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.location
}
output "name" {
  description = "The name of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.name
}
output "workspace_id" {
  description = "The workspace_id of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.workspace_id
}