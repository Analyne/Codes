  
output "SQL_name" {
  value = azurerm_sql_server.SQL.name
}


output "sql_location"{
  value = azurerm_sql_server.SQL.location
}

output "sql_version"{
  value = azurerm_sql_server.SQL.version
}

