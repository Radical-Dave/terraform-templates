variable "description" {
  description = "The location of the resource group"
  type        = string
  default     = "core"
}
variable "environment" {
  description = "The environment of the resource group"
  type        = string
  default     = "sbx"
}
variable "location" {
  description = "The location of the azurerm_network_watcher"
  type        = string
  default     = "eastus"
}
variable "name" {
  description = "The name of the azurerm_network_watcher"
  type        = string
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