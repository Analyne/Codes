provider "azurerm" {
 
  features {}
}

resource "azurerm_sql_server" "SQL" {
 name                         = var.name
  resource_group_name           = var.resourcegroupname
  location                     = var.location
  version                      = var.version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  tags     = var.tags
}




