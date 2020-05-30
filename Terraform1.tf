# Configure the Azure Provider
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.0.0"
  features {}
}
resource "azurerm_resource_group" "testing" {
  name     = "testing"
  location = "East US"
}

resource "azurerm_sql_server" "encoreserver01" {
  name                         = "encoreserver01"
  resource_group_name          = azurerm_resource_group.testing.name
  location                     = "East US"
  version                      = "12.0"
  administrator_login          = "myadmin"
  administrator_login_password = "azure@123456"

  tags = {
    environment = "QA-testing"
  }
}

resource "azurerm_storage_account" "encorestorage01" {
  name                     = "encorextorage01"
  resource_group_name      = azurerm_resource_group.testing.name
  location                 = azurerm_resource_group.testing.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "mysqldatabase01" {
  name                = "mysqldatabase01"
  resource_group_name = azurerm_resource_group.testing.name
  location            = "East US"
  server_name         = azurerm_sql_server.encoreserver01.name
 
  tags = {
    environment = "QA-testing"
  }
}