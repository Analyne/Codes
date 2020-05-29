provider "azurerm" {
 
  features {}
}

resource "azurerm_sql_database" "sqldb" {
  name                = var.name
  resource_group_name = var.resourcegroupname
  location            = var.location
  server_name         = var.servername
  edition             = var.edition
  requested_service_objective_name = var.requestedservice
  tags     = var.tags
}
