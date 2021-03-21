```
Codes
This is an Azure Terraform module Repository. Currently, we have below modules for use#
 module "sql-database" {
  #source              = "./Azure/Database"
   source              = "git://github.cerner.com/CSM/terraform_registry.git//azure_sql_server/Database/CreateDatabase/v1.0.0"
  resource_group_name = "Terraform"
  location            = "eastus"
  server_name         = "cesfindb"
  db_name             = "mydatad"
  sql_admin_username  = "mradministrators"
  sql_password        = "P@ssw0rd12345!"

  tags             = {
                        environment = "Dev"
                        Department  = "Transformation"
                      }
  
}
```

```
Terraform module output#
  output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = module.sql-database.database_name
}

output "sql_server_location" {
  description = "Location of the Azure SQL Database created."
  value       = module.sql-database.sql_server_location
}

output "sql_server_version" {
  description = "Version the Azure SQL Database created."
  value       = module.sql-database.sql_server_version
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = module.sql-database.sql_server_fqdn
}

output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = module.sql-database.connection_string
}

output "zone_redundant" {
   description ="Defines the replica of that database in a different zone"
   value      = module.sql-database.zone_redundant
}
```
# By deafault once DB is created in standard edition there is a preset backup in-place #

These variables must be set in the module block when using this module.
=========================================================================
resource_group_name string
Description: Default resource group name that the database will be created in.


db_name string
Description: The name of the database to be created.

location string
Description: The location/region where the database and server are created. Changing this forces a new resource to be created.

sql_admin_username string
Description: The administrator username of the SQL Server.

sql_password string
Description: The administrator password of the SQL Server.

# Optional Inputs 

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.
======================================================================================================================================

collation string
Description: The collation for the database. Default is SQL_Latin1_General_CP1_CI_AS
Default: "SQL_Latin1_General_CP1_CI_AS"

db_edition string
Description: The edition of the database to be created.
Default: "Standard"

end_ip_address string
Description: Defines the end IP address used in your database firewall rule.
Default: "0.0.0.0"

zone_redundant
Description: Defines if DB will have another DB in a different zone
Default:"False"



server_version string
Description: The version for the database server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server).
Default: "12.0"

service_objective_name string
Description: The performance level for the database. For the list of acceptable values.
Default: "Basic"

start_ip_address string
Description: Defines the start IP address used in your database firewall rule.
Default: "0.0.0.0"

tags map
Description: The tags to associate with your network and subnets.
Default: { "tag1": "", "tag2": "" }

Outputs
=======

database_name - The name of the Azure SQL Database created

sql_server_location - Location of the Azure SQL Database created

sql_server_version - Version of the Azure SQL Database created

sql_server_fqdn - Fully Qualified Domain Name (FQDN) of the Azure SQL Database created.

connection_string - Connection string for the Azure SQL Database created.

zone_redundant -  Defines the replica of that database in a different zone

