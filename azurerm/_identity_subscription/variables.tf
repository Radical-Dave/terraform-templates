variable "domain_name" {
  description = "The location of the resource group"
  type        = string
  default     = "onprem.local."
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "name" {
  description = "The name of the s3 bucket (Globally unique)"
  type        = string
  default     = "ident"
}
variable "resource_group_name" {
  description = "The resource_group_name defaults to rg-[name]-core-[location]"
  type        = string
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_egress_only_internet_gateway"
  type        = map(string)
  default     = {}
}