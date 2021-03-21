output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.db.name
}

output "sql_server_name_primary" {
  description = "Primary server name created."
  value       = azurerm_sql_server.primary.name
}


output "sql_server_name_secondary" {
  description = "Secondary server name created."
  value       = azurerm_sql_server.secondary.name
}

output "sql_server_location_primary" {
  description = "Location of the Azure SQL Database created for Primary."
  value       = azurerm_sql_server.primary.location
}


output "sql_server_location_secondary" {
  description = "Location of the Azure SQL Database created for Secondary."
  value       = azurerm_sql_server.secondary.location
}

output "sql_failover_name" {
  description = "Failover name created."
  value       = azurerm_sql_failover_group.failover.name
}