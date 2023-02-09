variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "backend_db" {
  description = "The backend_db of the resource group"
  type        = string
  default     = "{name}-backend-db"
}
variable "group" {
  description = "The group of the s3 bucket (Globally unique)"
  type        = string
  default     = "DevOps"
}
variable "name" {
  description = "The name of the s3 bucket (Globally unique)"
  type        = string
  default     = "cnct"
}
variable "prefix" {
  description = "The prefix of the s3 bucket (Globally unique)"
  type        = string
  default     = "DevOps"
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
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}