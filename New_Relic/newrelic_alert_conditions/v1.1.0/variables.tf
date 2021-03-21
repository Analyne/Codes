variable "app_name" {
  type        = string
  description = "APM application name - must be exactly the same as displayed in APM"
  default     = null
}

variable "alert_policy_id" {
  type        = string
  description = "ID of alert policy - can be defined in alert policy module, use output variable (alert_policy_id)"
  default     = null
}

variable "enable_alerts" {
  type = (object({
    low_apdex_score        = bool
    high_error_percentage  = bool
    high_response_time_web = bool
    low_throughput_web     = bool
  }))
  default = {
    low_apdex_score        = false
    high_error_percentage  = false
    high_response_time_web = false
    low_throughput_web     = false
  }
}

variable "apdex_score_settings" {
  type = (object({
    duration    = number
    threshold   = string
    runbook_url = string
  }))
  default = {
    duration    = 5
    threshold   = "0.75"
    runbook_url = null
  }
}

variable "error_percentage_settings" {
  type = (object({
    duration    = number
    threshold   = string
    runbook_url = string
  }))
  default = {
    duration    = 5
    threshold   = "5"
    runbook_url = null
  }
}

variable "response_time_web_settings" {
  type = (object({
    duration    = number
    threshold   = string
    runbook_url = string
  }))
  default = {
    duration    = 5
    threshold   = "5"
    runbook_url = null
  }
}

variable "throughput_web_settings" {
  type = (object({
    duration    = number
    threshold   = string
    runbook_url = string
  }))
  default = {
    duration    = 5
    threshold   = "50"
    runbook_url = null
  }
}