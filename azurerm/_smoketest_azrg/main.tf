data "azurerm_client_config" "current" {
}
module "azurerm_resource_group" {
  source   = "../azurerm_resource_group"
  name = "testing"
}