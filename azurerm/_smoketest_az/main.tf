data "azurerm_client_config" "current" {
}
module "local_file_debug" {
  source   = "../../local/local_file"
  content  = "clientid=${data.azurerm_client_config.current.client_id}"
  filename = "clientid.txt"
}

#module "write_files" {
#  source   = "../../../templates/local/write_files"
#content  = "clientid=${data.azurerm_client_config.current.client_id}"
#filename = "clientid.txt"
#  files  = { "clientid.txt" = "clientid=${data.azurerm_client_config.current.client_id}" }
#}