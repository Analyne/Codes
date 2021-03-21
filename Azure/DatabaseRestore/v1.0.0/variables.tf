variable "resource_group_name" {
  description = "Default resource group name that the database will be created in."
}

variable "location" {
  description = "The location/region where the database and server are created. Changing this forces a new resource to be created."
}

variable "server_version" {
  description = "The version for the database server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
}

variable "server_name" {
  description = "The name of the server to be created."
}

variable "db_name" {
  description = "The name of the database to be created."
}

variable "db_edition" {
  description = "The edition of the database to be created."
  default     = "Standard"
}

variable "service_objective_name" {
  description = "The performance level for the database. For the list of acceptable values, see https://docs.microsoft.com/en-gb/azure/sql-database/sql-database-service-tiers. Default is Basic."
  default     = "Standard"
}

variable "collation" {
  description = "The collation for the database. Default is SQL_Latin1_General_CP1_CI_AS"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_admin_username" {
  description = "The administrator username of the SQL Server."
}

variable "sql_password" {
  description = "The administrator password of the SQL Server."
}

variable "zone_redundant" {
  description = "Defines the replica of that database in a different zone"
  default     = "false"
}



variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map

  default = {
    tag1 = ""
    tag2 = ""
  }
}

variable "requestedservice" {
  description = "Defines Pricing tier."
  default     = "S0"
}

variable "max_size_gb" {
  description = "Defines database storage."
  default     = "250"
}

variable "source_database_id" {
  description = "Defines source db ID"
}

variable "restore_point_in_time" {
  description = "Defines restore point time of DB"
}