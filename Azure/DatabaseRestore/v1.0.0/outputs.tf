output "resource_group_name" {
  description = "Name of Resource group name."
  value       = azurerm_sql_database.dbs.resource_group_name
}

output "sql_server" {
  description = "SQL Server name created."
  value       = azurerm_sql_database.dbs.server_name
}


output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.dbs.name
}

output "db_location" {
  description = "Location of the Azure SQL Database created."
  value       = azurerm_sql_database.dbs.location
}