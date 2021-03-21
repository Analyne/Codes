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

variable "hostname_filter" {
  type        = string
  default     = null
  description = "WHERE clause to filter hostnames - Refer to NRQL syntax documentation"
}

variable "enable_alerts" {
  type = (object({
    low_disk_space     = bool
    high_cpu_usage     = bool
    high_memory_usage  = bool
    host_not_reporting = bool
  }))
  default = {
    low_disk_space     = false
    high_cpu_usage     = false
    high_memory_usage  = false
    host_not_reporting = false
  }
}

variable "low_disk_space_settings" {
  type = (object({
    duration    = number
    threshold   = number
    runbook_url = string
  }))
  default = {
    duration    = 10
    threshold   = 90
    runbook_url = null
  }
}

variable "high_cpu_usage_settings" {
  type = (object({
    duration    = number
    threshold   = number
    runbook_url = string
  }))
  default = {
    duration    = 10
    threshold   = 90
    runbook_url = null
  }
}

variable "high_memory_usage_settings" {
  type = (object({
    duration    = number
    threshold   = number
    runbook_url = string
  }))
  default = {
    duration    = 10
    threshold   = 90
    runbook_url = null
  }
}

variable "host_not_reporting_settings" {
  type = (object({
    duration    = number
    runbook_url = string
  }))
  default = {
    duration    = 10
    runbook_url = null
  }
}

variable "process_monitor_settings" {
  type = any
  default = {}
}