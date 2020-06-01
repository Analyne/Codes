provider "azurerm" {
 
  features {}
}

resource "azurerm_sql_database" "sqldb" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.server_name
  edition             = var.edition
  max_size_gb         = var.max_size_gb
  zone_redundant      = var.zone_redundant
  requested_service_objective_name = var.requestedservice
  tags                = var.tags
}