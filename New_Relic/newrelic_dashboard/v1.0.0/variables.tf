#-----------------------------------------------------------
# newrelic outside variables
#-----------------------------------------------------------

variable "name" {
  description = "(Optional) the newrelica appname"
  type        = string
  default     = ""  
}

variable "newrelic_appid" {
  description = "(Optional) the newrelica appnid"
  type        = number
  default     = null  
}

variable "dashboard" {
  description = "(Required) the switch for creating resource"
  type        = bool
  default     = false
}

variable "custom_dashboard" {
  description = "(Optional)) the switch for creating resource"
  type        = bool
  default     = false
}

#-----------------------------------------------------------
# newrelic dashboard required variables
#-----------------------------------------------------------

variable "dashboard_title" {
  description = "(Required) The title of the dashboard."
  type        = string
  default     = ""
}

#-----------------------------------------------------------
# newrelic dashboard optional variables
#-----------------------------------------------------------

variable "icon" {
  description = "(Optional) The icon for the dashboard."
  type        = string
  default     = "bar-chart"
}
  # Valid values are adjust, archive, bar-chart, bell, bolt, bug, bullhorn, bullseye, clock-o, cloud, cog, 
  # comments-o, crosshairs, dashboard, envelope, fire, flag, flask, globe, heart, leaf, legal, life-ring, line-chart, 
  # magic, mobile, money, none, paper-plane, pie-chart, puzzle-piece, road, rocket, shopping-cart, sitemap, sliders, tablet, thumbs-down, thumbs-up, trophy, usd, 
  # user, and users. Defaults to bar-chart.

variable "visibility" {
  description = "(Optional) Determines who can see the dashboard in an account."
  type        = string
  default     = "all"
}
  # Valid values are all or owner. Defaults to all.

variable "editable" {
  description = "(Optional) Determines who can edit the dashboard in an account."
  type        = string
  default     = "editable_by_all"   
}
  # Valid values are all, editable_by_all, editable_by_owner, or read_only. Defaults to editable_by_all.

#-----------------------------------------------------------
# newrelic dashboard filter nested block optional variables
#-----------------------------------------------------------

variable "filter" {
  description = "(Optional) A nested block that describes a dashboard filter. Exactly one nested filter block is allowed."
  type        = list(map(string))
  default     = []
}

  
variable "event_types" {
  description = "(Optional) A list of event types to enable filtering for."
  type        = list(string)
  default     = []
}

variable "attributes" {
  description = "(Optional) A list of attributes belonging to the specified event types to enable filtering for."
  type        = list(string)
  default     = []
}  

#-----------------------------------------------------------
# newrelic dashboard widget nested block optional variables
#-----------------------------------------------------------

variable "default_widgets" {
  description = "(Optional) The switch operation for the defalt widgets"
  type        = bool
  default     = true
}

variable "default_widget" {
  description = "(Optional) A list of default widgets for the defaul dashboard"
  type        = list(map(string))
}

variable "custom_widget" {
  description = "(Optional) A list of custom widgets you can pass"
  type        = list(map(string))  
}

  # (Optional) A nested block that describes a visualization. 
  # Up to 300 widget blocks are allowed in a dashboard definition.

#-----------------------------------------------------------
# newrelic dashboard required widget variables
#-----------------------------------------------------------

variable "title" {
  description = "(Required) A title for the widget."
  type        = string
  default     = ""
}

variable "visualization" {
  description = "(Required) How the widget visualizes data."
  type        = string
  default     = ""
}
  # Valid values are billboard, gauge, billboard_comparison, facet_bar_chart, faceted_line_chart, 
  # facet_pie_chart, facet_table, faceted_area_chart, heatmap, attribute_sheet, single_event, 
  # histogram, funnel, raw_json, event_feed, event_table, uniques_list, line_chart, comparison_line_chart, 
  # markdown, and metric_line_chart.

variable "row" {
  description = "(Required) Row position of widget from top left, starting at 1."
  type        = number
  default     = 1
}

variable "column" {
  description = "(Required) Column position of widget from top left, starting at 1."
  type        = number
  default     = 1
}

#-----------------------------------------------------------
# newrelic dashboard optional widget variables
#-----------------------------------------------------------

variable "width" {
  description = "(Optional) Width of the widget. Valid values are 1 to 3 inclusive. Defaults to 1."
  type        = number
  default     = 1
}

variable "height" {
  description = "(Optional) height of the widget. Valid values are 1 to 3 inclusive. Defaults to 1."
  type        = number
  default     = 1
}

variable "note" {
  description = "(Optional) Description of the widget."
  type        = string
  default     = "managed by terraform"
}

#-----------------------------------------------------------
# newrelic dashboard visualization variables
#-----------------------------------------------------------

variable "nrql" {
  description = "(Required) Valid NRQL query string. See Writing NRQL Queries for help."
  type        = string
  default     = null
}

variable "threshold_red" {
  description = "(Optional) Threshold above which the displayed value will be styled with a red color."
  type        = number
  default     = null
}

variable "threshold_yellow" {
  description = "(Optional) Threshold above which the displayed value will be styled with a yellow color."
  type        = number
  default     = null
}

variable "drilldown_dashboard_id" {
  description = "(Optional) The ID of a dashboard to link to from the widget's facets."
  type        = string
  default     = null
}

variable "markdown_source" {
  description = "(Required) The markdown source to be rendered in the widget."
  type        = string
  default     = null
}

variable "entity_id" {
  description = "(Required) A collection of entity ids to display data for. These are typically application IDs."
  type        = number
  default     = 0
}

variable "entity_ids" {
  description = "(Required) A collection of entity ids to display data for. These are typically application IDs."
  type        = list(number)
  default     = []
}

variable "duration" {
  description = "(Required) The duration, in ms, of the time window represented in the chart."
  type        = number
  default     = null
}

variable "end_time" {
  description = "(Optional) The end time of the time window represented in the chart in epoch time. When not set, the time window will end at the current time."
  type        = string
  default     = null
}

variable "facet" {
  description = "(Optional) Can be set to host to facet the metric data by host."
  type        = string
  default     = null
}

variable "limit" {
  description = "(Optional) The limit of distinct data series to display."
  type        = number
  default     = null
}

#-----------------------------------------------------------
# newrelic dashboard visualization metric nested block
#-----------------------------------------------------------

variable "metric_name" {
  description = "(Required) The metric name to display."
  type        = string
  default     = null
}

variable "metric_values" {
  description = "(Required) The metric values to display."
  type        = list(string)
  default     = null
}


