resource "azurerm_sql_database" "dbs" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  location            = var.location
  edition             = var.db_edition
  server_name         = var.server_name
  create_mode         = "copy"
  source_database_id  = "/subscriptions/95ead6ea-7b3e-4f4f-b069-c4066f7e940d/resourceGroups/Terraform/providers/Microsoft.Sql/servers/cesfindb/databases/mydatad"
  tags                = var.tags
}