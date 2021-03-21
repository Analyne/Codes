variable "custom_widget" {
  description = "(Optional) These are the custome widgets you can pass through tfvars"
  type        = list(map(string))
  default     = []
}

variable "filter" {
  description = "(Optional) These are the custome widgets you can pass through tfvars"
  type        = list(map(string))
  default     = []
}

variable "name" {
  description = "(Optional) This is the name of the application, it can be used in NRQL variables"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "(Required) This will be passed through the data point and help fill in other variables"
  type        = string
}

variable "dashboard_slislo_threshold_settings" {
  description = "(Required) Threshold above which the displayed value will be styled with a red or yellow color."
  type = (object({
    responsetime_red  = number
    responsetime_yellow = number
    errorrate_red = number
    errorrate_yellow = number
  }))
  default     = null
}