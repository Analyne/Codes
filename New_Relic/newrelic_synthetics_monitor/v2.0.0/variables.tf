variable "app_name" {
  type        = string
  default     = null
  description = "(Required) The name of the app/site being monitored."
}

variable "alert_policy_id" {
  type        = string
  default     = null
  description = "ID of alert policy - can be defined in alert policy module, use output variable (alert_policy_id)"
}

variable "synthetic_monitor_settings" {
  type        = any
  default     = {}
  description = "Object mapping of settings for synthetic monitors"
}