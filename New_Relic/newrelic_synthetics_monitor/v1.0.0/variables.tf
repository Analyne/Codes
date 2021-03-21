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
  type = map(object({
    uri                       = string
    type                      = string
    frequency                 = number
    status                    = string
    locations                 = list(string)
    sla_threshold             = number
    validation_string         = string
    verify_ssl                = bool
    bypass_head_request       = bool
    treat_redirect_as_failure = bool
    enable_alert_condition    = bool
    runbook_url               = string
  }))
}