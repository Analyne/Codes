output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = "${azurerm_sql_database.db.name}"
}

output "sql_server_location" {
  description = "Location of the Azure SQL Database created."
  value       = azurerm_sql_server.server.location
}

output "sql_server_version" {
  description = "Version the Azure SQL Database created."
  value       = azurerm_sql_server.server.version
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = azurerm_sql_server.server.fully_qualified_domain_name
}

output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

output "zone_redundant" {
  description = "Defines the replica of that database in a different zone"
  value       = azurerm_sql_database.db.zone_redundant
}