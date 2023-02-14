variable "name" {
  description = "The name of the azurerm_network_watcher"
  type        = string
}
variable "location" {
  description = "The location of the azurerm_network_watcher"
  type        = string
  default     = "eastus"
}
variable "resource_group_name" {
  description = "The resource_group_name of the azurerm_network_watcher"
  type        = string
}
variable "tags" {
  description = "Tags for the azurerm_network_watcher"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}