variable "name" {
  description = "The name of the subnet"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the subnet"
  type        = string
  default     = null
}
variable "private_dns_resolver_id" {
  description = "The private_dns_resolver_id of the subnet"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "subnet_id" {
  description = "The subnet_id of the resource group"
  type        = string
  default     = null
}
variable "virtual_network_name" {
  description = "The virtual_network_name of the subnet"
  type        = string
  default     = null
}
variable "address_prefixes" {
  description = "The address_prefixes of the subnet"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}