output "id" {
  description = "The id of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.id
}
output "soa_record" {
  description = "The soa_record of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.soa_record
}
output "number_of_record_sets" {
  description = "The number_of_record_sets of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.number_of_record_sets
}
output "max_number_of_record_sets" {
  description = "The max_number_of_record_sets of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.max_number_of_record_sets
}
output "max_number_of_virtual_network_links" {
  description = "The max_number_of_virtual_network_links of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.max_number_of_virtual_network_links
}
output "max_number_of_virtual_network_links_with_registration" {
  description = "The max_number_of_virtual_network_links_with_registration of the azurerm_private_dns_zone provisioned"
  value       = azurerm_private_dns_zone.this.max_number_of_virtual_network_links_with_registration
}