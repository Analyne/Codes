resource "azurerm_sql_database" "dbs" {
  name                  = var.db_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  edition               = var.db_edition
  server_name           = var.server_name
  create_mode           = "PointInTimeRestore"
  source_database_id    = var.source_database_id
  restore_point_in_time = var.restore_point_in_time

  tags = var.tags
}