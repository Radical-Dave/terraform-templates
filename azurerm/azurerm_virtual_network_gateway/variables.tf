variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
  default     = "eastus"
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "public_ip_address_id" {
  description = "The public_ip_address_id of the virtual network"
  type        = string
  default     = null
}
variable "private_ip_address_allocation " {
  description = "The private_ip_address_allocation  of the virtual network"
  type        = string
  default     = "Dynamic"
}

variable "sku" {
  description = "The name of the resource group"
  type        = string
  default     = "VpnGw1"
}
variable "subnet" {
  description = "Subnet for the virtual network"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}