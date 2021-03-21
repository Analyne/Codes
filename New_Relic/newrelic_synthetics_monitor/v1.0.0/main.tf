### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic synthetics monitors and condtions.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/synthetics_monitor.html
# https://www.terraform.io/docs/providers/newrelic/r/synthetics_alert_condition.html
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_synthetics_monitor" "synthetics_monitor" {
  for_each = var.synthetic_monitor_settings

  name          = "${var.app_name}_${each.key}"
  type          = each.value.type
  frequency     = each.value.frequency
  status        = each.value.status
  locations     = each.value.locations
  sla_threshold = each.value.sla_threshold

  uri                       = each.value.type == "SIMPLE" || each.value.type == "BROWSER" ? each.value.uri : null               # Required for type "SIMPLE" and "BROWSER"
  validation_string         = each.value.type == "SIMPLE" || each.value.type == "BROWSER" ? each.value.validation_string : null # Optional for type "SIMPLE" and "BROWSER"
  verify_ssl                = each.value.type == "SIMPLE" || each.value.type == "BROWSER" ? each.value.verify_ssl : null        # Optional for type "SIMPLE" and "BROWSER"
  bypass_head_request       = each.value.type == "SIMPLE" ? each.value.bypass_head_request : null                               # Optional for type "SIMPLE" only
  treat_redirect_as_failure = each.value.type == "SIMPLE" ? each.value.treat_redirect_as_failure : null                         # Optional for type "SIMPLE" only
}

resource "newrelic_synthetics_alert_condition" "synthetics_alert" {
  for_each  = var.synthetic_monitor_settings
  policy_id = var.alert_policy_id

  name        = "${var.app_name}_${each.key}_condition"
  monitor_id  = newrelic_synthetics_monitor.synthetics_monitor[each.key].id
  runbook_url = each.value.runbook_url
  enabled     = each.value.enable_alert_condition
}