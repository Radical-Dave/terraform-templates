terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "d4dcf2f0-f230-4785-ac04-a37ed6e439ee"
  client_id       = "cdbc55e5-1f66-48dc-a69f-ee67dd1fa5d4"
  client_secret   = "liGFjPWb.Ls7phPl_VNrx4zsA_xMTkD5mn"
  tenant_id       = "e3c1b2e3-3961-4882-925a-94cf6bf2170a"
}