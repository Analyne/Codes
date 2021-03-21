# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# Provider information
# ----------------------------------------------------------------------------------------------------------------------

# provider "newrelic" {
#   version = "~> 1.15.1"
# }

# ----------------------------------------------------------------------------------------------------------------------
# New Relic data points
# ----------------------------------------------------------------------------------------------------------------------

data "newrelic_application" "application" {
  name = var.app_name
}
locals {
  name = data.newrelic_application.application.name
}
# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates the New Relic Dashboard.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/dashboard.html
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_dashboard" "slislo" {
  title = "'${local.name}' SLI/SLO Dashboard"

  widget {
    title            = "Error rate 500"
    visualization    = "billboard"
    nrql             = "SELECT percentage(count(httpResponseCode), WHERE httpResponseCode in ('500','501','502','503','504','505','506','507','508','509','510','511')) FROM Transaction WHERE appName = '${local.name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.errorrate_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.errorrate_yellow
    row              = 1
    column           = 1
    width            = 1
    height           = 1
  }

  widget {
    title         = "Error Rate Timeseries"
    visualization = "line_chart"
    nrql          = "SELECT percentage(count(httpResponseCode), WHERE httpResponseCode in ('500','501','502','503','504','505','506','507','508','509','510','511')) FROM Transaction WHERE appName = '${local.name}' SINCE 2 weeks ago TIMESERIES AUTO"
    threshold_red    = var.dashboard_slislo_threshold_settings.errorrate_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.errorrate_yellow
    row              = 1
    column           = 3
    width            = 2
    height           = 1
  }

  widget {
    title            = "Response Time 95th Percentile"
    visualization    = "billboard"   
    nrql             = "Select percentile(duration,95) AS 'Average Response 95%' FROM Transaction WHERE appName = '${local.name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.responsetime_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.responsetime_yellow
    row              = 2
    column           = 1
    width            = 1
    height           = 1
  }

  widget {
    title         = "Response Time Timechart"
    visualization = "line_chart"    
    nrql          = "Select percentile(duration,95) AS 'Average MS Response 95%' FROM Transaction TIMESERIES AUTO WHERE appName = '${local.name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.responsetime_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.responsetime_yellow
    row              = 1
    column           = 2
    width            = 2
    height           = 1
  }
}



