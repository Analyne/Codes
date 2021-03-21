variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group"
}

variable "location" {
  type        = string
  description = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"
}


variable "name" {
  type        = string
  description = "The name of the Azure Key Vault"
}

variable "sku_name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "enabled_for_deployment" {
  type        = string
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = "false"
}

variable "enabled_for_disk_encryption" {
  type        = string
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys" 
  default     = "false"
}

variable "enabled_for_template_deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = "false"
}
variable "bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
  default     = "None"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "subnetIds" {
  description = "A mapping of tags to assign to the resource"
  type        = list(string)
  default     = []
}

variable "policies" {
  type = map(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "Define a Azure Key Vault access policy"
  default = {}
}

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default = {}
}