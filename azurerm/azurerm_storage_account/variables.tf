variable "account_replication_type" {
  description = "The account_replication_type of the storage account"
  type        = string
  default     = "LRS"
}
variable "account_tier" {
  description = "The account_tier of the storage account"
  type        = string
  default     = "Standard"
}
variable "allow_nested_items_to_be_public" {
  description = "The public_network_access_enabled of the resource group"
  type        = bool
  default     = false
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}
variable "name" {
  description = "The name of the storage account"
  type        = string
  default     = null
}
variable "public_network_access_enabled" {
  description = "The public_network_access_enabled of the resource group"
  type        = bool
  default     = false
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}
variable "virtual_network_subnet_ids" {
  description = "The virtual_network_subnet_ids of the storage account"
  type        = set(string)
  default     = null
}