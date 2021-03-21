resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus"
}


resource "azurerm_sql_server" "primary" {
  name                         = var.server_primary_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location_primary
  version                      = var.server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_password
  tags                         = var.tags
}


resource "azurerm_sql_server" "secondary" {
  name                         = var.server_secondary_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location_secondary
  version                      = var.server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_password
  tags                         = var.tags
}



resource "azurerm_sql_database" "db" {
  name                             = var.db_name
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_sql_server.primary.location
  edition                          = var.db_edition
  collation                        = var.collation
  server_name                      = azurerm_sql_server.primary.name
  create_mode                      = "Default"
  max_size_gb                      = var.max_size_gb
  zone_redundant                   = var.zone_redundant
  requested_service_objective_name = var.service_objective_name
  tags                             = var.tags
}


resource "azurerm_sql_failover_group" "failover" {
  name                = var.failover_name
  resource_group_name = azurerm_sql_server.primary.resource_group_name
  server_name         = azurerm_sql_server.primary.name
  databases           = [azurerm_sql_database.db.id]
  partner_servers {
    id = azurerm_sql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}


resource "azurerm_sql_firewall_rule" "fw" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.primary.name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}