variable "policy_name" {
  type        = string
  default     = null
  description = "Name of related alert policy."
}

variable "account_id" {
  type        = string
  default     = null
  description = "New Relic Account ID."
}

variable "alert_muting_rules" {
  type        = any
  default     = {}
  description = ""
}