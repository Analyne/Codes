### Module Version 2.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.12.1"
    }
  }
  required_version = ">= 0.13.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates the New Relic Dashboard.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/dashboard.html
# ----------------------------------------------------------------------------------------------------------------------

data "newrelic_application" "application" {
  count  = var.app_name != "" && var.app_name != null && var.enable_dashboard ? 1 : 0
  name   = var.app_name
}

data "newrelic_entity" "application" {
  count  = var.app_name != "" && var.app_name != null && var.enable_dashboard ? 1 : 0
  name = var.app_name
  domain = "APM"
  type = "APPLICATION"
  tag {
    key = "accountID"
    value = var.account_id
  }
}

resource "newrelic_dashboard" "slislo" {
  count = var.app_name != "" && var.app_name != null && var.enable_dashboard && local.app_id != null ? 1 : 0
  title = "'${data.newrelic_entity.application[0].name}' SLI/SLO Dashboard"

  widget {
    title            = "Error rate 500"
    visualization    = "billboard"
    nrql             = "SELECT percentage(count(httpResponseCode), WHERE httpResponseCode in ('500','501','502','503','504','505','506','507','508','509','510','511')) FROM Transaction WHERE appName = '${data.newrelic_entity.application[0].name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.errorrate_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.errorrate_yellow
    row              = 1
    column           = 1
    width            = 1
    height           = 1
  }

  widget {
    title            = "Error Rate Timeseries"
    visualization    = "line_chart"
    nrql             = "SELECT percentage(count(httpResponseCode), WHERE httpResponseCode in ('500','501','502','503','504','505','506','507','508','509','510','511')) FROM Transaction WHERE appName = '${data.newrelic_entity.application[0].name}' SINCE 2 weeks ago TIMESERIES AUTO"
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
    nrql             = "Select percentile(duration,95) AS 'Average Response 95%' FROM Transaction WHERE appName = '${data.newrelic_entity.application[0].name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.responsetime_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.responsetime_yellow
    row              = 2
    column           = 1
    width            = 1
    height           = 1
  }

  widget {
    title            = "Response Time Timechart"
    visualization    = "line_chart"
    nrql             = "Select percentile(duration,95) AS 'Average MS Response 95%' FROM Transaction TIMESERIES AUTO WHERE appName = '${data.newrelic_entity.application[0].name}' SINCE 2 weeks ago"
    threshold_red    = var.dashboard_slislo_threshold_settings.responsetime_red
    threshold_yellow = var.dashboard_slislo_threshold_settings.responsetime_yellow
    row              = 1
    column           = 2
    width            = 2
    height           = 1
  }
}

locals {
  app_id = var.app_name != "" && var.app_name != null && var.enable_dashboard ? data.newrelic_entity.application[0].application_id : null
}