resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_sql_server" "server" {
  name                         = var.server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = var.server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_password
  tags                         = var.tags
}


resource "azurerm_sql_database" "db" {
  name                             = var.db_name
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = var.location
  edition                          = var.db_edition
  collation                        = var.collation
  server_name                      = azurerm_sql_server.server.name
  create_mode                      = "Default"
  max_size_gb                      = var.max_size_gb
  zone_redundant                   = var.zone_redundant
  requested_service_objective_name = var.service_objective_name
  tags                             = var.tags
}


resource "azurerm_sql_firewall_rule" "fw" {
  count               = var.ip_count
  name                = var.fw_name[count.index]
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = var.start_ip_address[count.index]
  end_ip_address      = var.end_ip_address[count.index]
}