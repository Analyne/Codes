  
output "sqldb_name" {
  value = azurerm_sql_database.sqldb.name
}


output "sqldb_location"{
  value = azurerm_sql_database.sqldb.location
}

output "sqldb_maxsize"{
  value = azurerm_sql_database.sqldb.max_size_gb
}



