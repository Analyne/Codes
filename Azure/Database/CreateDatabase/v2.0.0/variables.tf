variable "resource_group_name" {
  description = "Default resource group name that the database will be created in."
  default     = "Terraform"
}

variable "location" {
  description = "The location/region where the database and server are created. Changing this forces a new resource to be created."
  default = null
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


variable "start_ip_address" {
  description = "Defines the start IP address used in your database firewall rule."
  type        = list(string)
  default     = ["0.0.0.0", "10.0.0.0", "34.209.118.190", "52.25.77.200", "52.11.246.108", "159.140.254.0", "159.140.0.0", "159.140.252.0", "80.69.16.80", "89.187.126.32", "123.63.30.29", "122.15.145.129", "182.75.26.24", "182.75.167.184", "182.75.124.16", "45.124.40.0", "45.124.41.0", "45.124.41.32"]
}

variable "end_ip_address" {
  description = "Defines the end IP address used in your database firewall rule."
  type        = list(string)
  default     = ["0.0.0.0", "10.255.255.255", "34.209.118.190", "52.25.77.200", "52.11.246.108", "159.140.254.255", "159.140.255.255", "159.140.252.255", "80.69.16.95", "89.187.126.47", "123.63.30.29", "122.15.145.159", "182.75.26.31", "182.75.167.191", "182.75.124.23", "45.124.40.15", "45.124.41.15", "45.124.41.47"]
}

variable "ip_count" {
  default     = 18
  description = "No of IPS"
}

variable "fw_name" {
  description = "Defines firewall name."
  type        = list(string)
  default     = ["Rule1", "Rule2", "Rule3", "Rule4", "Rule5", "Rule6", "Rule7", "Rule8", "Rule9", "Rule10", "Rule11", "Rule12", "Rule13", "Rule14", "Rule15", "Rule16", "Rule17", "Rule18"]
}
