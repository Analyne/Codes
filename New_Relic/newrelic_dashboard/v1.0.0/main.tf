# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates the New Relic Dashboard.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/dashboard.html
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_dashboard" "dashboard" {
  count      = var.dashboard ? 1 : 0
  # -- required arguments for the resource
  title      = var.dashboard_title != "" ? lower(var.dashboard_title) : "${var.name}-dashboard" 

  # -- optional argument for the resource
  icon       = var.icon
  visibility = var.visibility
  editable   = var.editable

  dynamic "filter" {
    for_each = var.filter
    content {
      event_types = filter.value["event_types"]
      attributes  = filter.value["attributes"]
    }
  }

  # -- optional nested blocks
  dynamic "widget" {
    for_each = var.default_widget
    content {
			# -- required arguments for the nested block
			title 				         = widget.value["title"]
			visualization          = widget.value["visualization"]
			row						         = widget.value["row"]
			column 				         = widget.value["column"]
			# -- optional arguments for the nested block
			width					         = widget.value["width"]
			height				         = widget.value["height"]
			nrql                   = widget.value["nrql"]
			threshold_red          = widget.value["threshold_red"]
			threshold_yellow       = widget.value["threshold_yellow"]
    }
  }
  # -- optional custome widgets 
  dynamic "widget" {
    for_each = var.custom_widget
    content {
      # -- required arguments for the nested block
			title 				         = widget.value["title"]
			visualization          = widget.value["visualization"]
			row						         = widget.value["row"]
			column 				         = widget.value["column"]
			# -- optional arguments for the nested block
			width					         = widget.value["width"]
			height				         = widget.value["height"]
			nrql                   = widget.value["nrql"]
			threshold_red          = widget.value["threshold_red"]
			threshold_yellow       = widget.value["threshold_yellow"]
    }
  } 
}

# v.1.0.0 