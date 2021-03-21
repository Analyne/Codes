```
This is an Azure Terraform module for Database copy to different server or same server . To copy an existing DB to another server or same 
server use the module copy_database and existing module for DB creation(sql-database)

module "copy_database" {
#source              = "./../../Azure/DBCopy"
source               = "git://github.cerner.com/CSM/terraform_registry.git//azure_sql_server/DatabaseCopy/v3.0.0"
resource_group_name = module.sql-database.resource_group_name
server_name         = module.sql-database.sql_server_name
location            = "eastus"
db_name             = "mydatads"
sql_admin_username  = "mradministrator"
sql_password        = "P@ssw0rd12345!"
source_database_id  = "/subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/databases/mydatad"
tags             = {
                        environment = "dev"
                        costcenter  = "it"
                      }
  
} 



Existing DB module

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


Must import the existing resource using below before running terraform apply


terraform import module.sql-database.azurerm_resource_group.rg /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform
terraform import module.sql-database.azurerm_sql_server.server /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb
terraform import module.sql-database.azurerm_sql_database.db /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/databases/mydatad
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[0] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule1
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[1] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule2
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[2] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule3
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[3] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule4
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[4] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule5
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[5] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule6
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[6] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule7
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[7] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule8
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[8] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule9
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[9] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule10
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[10] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule11
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[11] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule12
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[12] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule13
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[13] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule14
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[14] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule15
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[15] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule16
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[16] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule17
terraform import module.sql-database.azurerm_sql_firewall_rule.fw[17] /subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/firewallRules/Rule18




```

```
Terraform module output
=======================

output "database_name" {
description = "Database name of the Azure SQL Database created."
value       = module.copy_database.database_name
}

output "db_location" {
description = "Location of the Azure SQL Database created."
value       = module.copy_database.db_location
}

output "sql_server" {
description ="SQL Server name created."
value      = module.copy_database.sql_server
}

output "resource_group_name" {
description ="Defines the resource group name"
value      = module.copy_database.resource_group_name
}


```


Outputs
========
resource_group_name string
Description: Default resource group name that the database will be created in.


db_name string
Description: The name of the database to be created.

location string
Description: The location/region where the database was created.

sql_server string
Description: SQL Server name created.


