variable "app_name" {
  type        = string
  default     = null
  description = "Name of application - Must be exactly the same as APM"
}

variable "alert_policy_id" {
  type        = string
  default     = null
  description = "ID of alert policy - can be defined in alert policy module, use output variable (alert_policy_id)"
}

variable "nrql_alert_conditions" {
  type        = any
  default     = {}
  description = ""
}