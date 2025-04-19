variable "subscription_id" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
resource "azurerm_resource_group" "tfstate" {
  name     = "terraform-state-rg"
  location = "eastus"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
