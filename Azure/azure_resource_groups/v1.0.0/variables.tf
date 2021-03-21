variable "resource_groups" {
  type = map(object({
    location = string
    tags     = map(string)
  }))
  description = "Object Mapping of resource groups."
  default     = {}
}

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