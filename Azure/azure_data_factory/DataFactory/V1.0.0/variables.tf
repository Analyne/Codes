variable "location" {
    default = "Central US"
     description = "Azure Resource Group Location"
}

variable "rg_name" {
    type = string
    description = "Azure Resource Group Name"
}

variable "tags" {
    type = map
    description = "The tags to be associated with your Data Factory"
}

variable "df_name" {
    type = string
    description = "Azure Data Factory Name"
}