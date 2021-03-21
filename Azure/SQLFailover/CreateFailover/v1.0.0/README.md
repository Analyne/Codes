This is an Azure terraform module respository. Use below for creating SQL failover group


````
 module "sqlserver_failover" {
  #source              = "./Azure/Database1"
  source               = "git://github.cerner.com/AI044260/Codes.git//SQLFailover"
  resource_group_name = "Terraform"
  server_primary_name = "cesfindb"
  server_secondary_name="terraformdb1"

  location_primary    = "eastus"
  location_secondary  =  "westus"
  db_name             = "mydatad"
  sql_admin_username  = "mradministrator"
  sql_password        = "P@ssw0rd12345!"
  failover_name       ="analyne12"

  tags             = {
                        environment = "DEV"
                        costcenter  = "IT"
                      }
  
}

```
Module description:   

resource_group_name==> Resource group name
db_name ==> DB name
failover_name ==> Failover name
location_primary ==> Primary SQL Server and  DB location 
location_secondary ==> Secondary SQL Server and DB location
server_primary_name ==> Primary SQL Server name 
server_secondary_name ==> Secondary Server name
sql_admin_username ==> SQL Server username
sql_password ==> SQL Server password


output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = module.sqlserver_failover.database_name
}

output "sql_server_name_primary" {
  description = "Primary server name created."
  value       = module.sqlserver_failover.sql_server_name_primary
}


output "sql_server_name_secondary" {
  description = "Secondary server name created."
  value       =  module.sqlserver_failover.sql_server_name_secondary
}

output "sql_server_location_primary" {
  description = "Location of the Azure SQL Database created for Primary."
  value       = module.sqlserver_failover.sql_server_location_primary
}


output "sql_server_location_secondary" {
  description = "Location of the Azure SQL Database created for Secondary."
  value       = module.sqlserver_failover.sql_server_location_secondary
}

output "sql_failover_name" {
  description = "Failover name created."
  value       = module.sqlserver_failover.sql_failover_name
}

Output will look like below 


Outputs:

database_name = mydatad
sql_failover_name = analyne12
sql_server_location_primary = eastus
sql_server_location_secondary = westus
sql_server_name_primary = cesfindb
sql_server_name_secondary = terraformdb1


