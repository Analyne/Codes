### Module Version 2.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.13.0"
    }
  }
  required_version = ">= 0.13"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic synthetics monitors and condtions.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/synthetics_monitor.html
# https://www.terraform.io/docs/providers/newrelic/r/synthetics_alert_condition.html
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/synthetics_monitor_script
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_synthetics_monitor" "synthetics_monitor" {
  for_each = var.synthetic_monitor_settings

  name          = "${var.app_name}_${each.key}"
  type          = upper(each.value.type)
  frequency     = each.value.frequency
  status        = each.value.status
  locations     = each.value.locations
  sla_threshold = lookup(each.value, "sla_threshold", null)

  uri                       = upper(each.value.type) == "SIMPLE" || upper(each.value.type) == "BROWSER" ? each.value.uri : null                                # Required for type "SIMPLE" and "BROWSER"
  validation_string         = upper(each.value.type) == "SIMPLE" || upper(each.value.type) == "BROWSER" ? lookup(each.value, "validation_string", null) : null # Optional for type "SIMPLE" and "BROWSER"
  verify_ssl                = upper(each.value.type) == "SIMPLE" || upper(each.value.type) == "BROWSER" ? lookup(each.value, "verify_ssl", null) : null        # Optional for type "SIMPLE" and "BROWSER"
  bypass_head_request       = upper(each.value.type) == "SIMPLE" ? lookup(each.value, "bypass_head_request", null) : null                                      # Optional for type "SIMPLE" only
  treat_redirect_as_failure = upper(each.value.type) == "SIMPLE" ? lookup(each.value, "treat_redirect_as_failure", null) : null                                # Optional for type "SIMPLE" only
}

resource "newrelic_synthetics_alert_condition" "synthetics_alert" {
  for_each  = var.synthetic_monitor_settings
  policy_id = var.alert_policy_id

  name        = "${var.app_name}_${each.key}_condition"
  monitor_id  = newrelic_synthetics_monitor.synthetics_monitor[each.key].id
  runbook_url = lookup(each.value, "runbook_url", null)
  enabled     = each.value.enable_alert_condition
}

resource "newrelic_synthetics_monitor_script" "synthetics_script" {
  for_each = {
    for monitor, scripted in var.synthetic_monitor_settings : monitor => scripted
    if upper(scripted.type) == "SCRIPT_BROWSER" || upper(scripted.type) == "SCRIPT_API"
  }

  monitor_id = newrelic_synthetics_monitor.synthetics_monitor[each.key].id
  text       = file("${path.root}/${each.value.script_file}")
}