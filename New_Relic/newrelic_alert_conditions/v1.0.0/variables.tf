variable "app_name" {
  type        = string
  description = "APM application name - must be exactly the same as displayed in APM"
  default     = null
}

variable "alert_policy_id" {
  type        = string
  description = "ID of alert policy to associate alerts with."
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
  description = "Boolean objects to decide which alerts to create."
}

variable "apdex_score_settings" {
  type = (object({
    duration  = number
    threshold = string
  }))
  default = {
    duration  = 5
    threshold = "0.75"
  }
  description = "apdex score critical threshold and duration settings."
}

variable "error_percentage_settings" {
  type = (object({
    duration  = number
    threshold = string
  }))
  default = {
    duration  = 5
    threshold = "5"
  }
  description = "error percentage critical threshold and duration settings."
}

variable "response_time_web_settings" {
  type = (object({
    duration  = number
    threshold = string
  }))
  default = {
    duration  = 5
    threshold = "5"
  }
  description = "response time web critical threshold and duration settings."
}

variable "throughput_web_settings" {
  type = (object({
    duration  = number
    threshold = string
  }))
  default = {
    duration  = 5
    threshold = "50"
  }
  description = "throughput web critical threshold and duration settings."
}