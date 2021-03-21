variable "resource_group_name" {
  type        = string
  description = "The resource group that the DNS zones/records will be created within."
  default     = null
}

variable "dns_zones_and_records" {
  type = map(object({
    tags = map(string)
    recordsets = map(object({
      record_name = string
      record_type = string
      ttl         = number
      records     = list(string)
      tags        = map(string)
    }))
  }))
  description = "Object mapping for creation of zones and respective records."
  default     = {}
}

### INCOMPLETE - RESERVED FOR FUTURE VERSION ###
# variable "azure_alias_a_and_aaaa_records" {
#   type = map(object({
#     record_type = string
#     zone_name = string
#     target_ip_name = string
#     target_ip_resource_group_name = string
#     ttl = number
#     tags = map(string)
#   }))
# }

# variable "azure_alias_cname_records" {
#   type = map(object({
#     record_type       = string
#     zone_name         = string
#     ttl               = number
#     target_cname_fqdn = string
#     tags              = map(string)
#   }))
#   default = {}
# }
################################################

variable "tags" {
  type        = map(string)
  description = "Mapping for azure resource metadata tags that will apply to all resources."
  default     = {}
}

variable "auto_tags" {
  type        = map(string)
  description = "For use in automation. Merges with 'tags' variable."
  default     = {}
}