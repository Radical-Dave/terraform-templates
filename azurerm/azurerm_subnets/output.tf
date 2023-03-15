output "subnets" {
  description = "Map output of the managed subnets"
  value       = { for k, b in azurerm_subnet.subnets : k => b }
}