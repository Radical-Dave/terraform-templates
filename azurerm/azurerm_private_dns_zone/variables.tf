variable "name" {
  description = "The name of the azurerm_private_dns_zone"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group of the azurerm_private_dns_zone"
  type        = string
  default     = null
}
variable "soa_record_email" {
  description = "The soa_record_email of the azurerm_private_dns_zone"
  type        = string
  default     = null
}
variable "soa_record_expire_time" {
  description = "The soa_record_expire_time of the azurerm_private_dns_zone"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the azurerm_private_dns_zone"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}