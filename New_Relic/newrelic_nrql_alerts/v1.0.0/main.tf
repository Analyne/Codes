### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.14.0"
    }
  }
  required_version = ">= 0.13.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic NRQL alert conditions.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_nrql_alert_condition" "nrql_alert_condition" {
  for_each = var.nrql_alert_conditions

  policy_id                      = var.alert_policy_id
  name                           = "${var.app_name}_${each.key}_nrql"
  description                    = lookup(each.value, "description", null)
  type                           = lookup(each.value, "type", null)
  runbook_url                    = lookup(each.value, "runbook_url", null)
  enabled                        = lookup(each.value, "enabled", null)
  violation_time_limit_seconds   = lookup(each.value, "violation_time_limit", 86400)
  value_function                 = lower(lookup(each.value, "type", "static")) == "static" ? lookup(each.value, "value_function", "single_value") : lookup(each.value, "value_function", null)
  fill_option                    = lookup(each.value, "fill_option", null)
  fill_value                     = lookup(each.value, "fill_value", null)
  aggregation_window             = lookup(each.value, "aggregation_window", null)
  expiration_duration            = lookup(each.value, "expiration_duration", null)
  open_violation_on_expiration   = lookup(each.value, "open_violation_on_expiration", null)
  close_violations_on_expiration = lookup(each.value, "close_violations_on_expiration", null)

  # Baseline only
  baseline_direction = lower(lookup(each.value, "type", "static")) == "baseline" ? lookup(each.value, "baseline_direction", null) : null

  # Outlier Only
  expected_groups                 = lower(lookup(each.value, "type", "static")) == "outlier" ? lookup(each.value, "expected_groups", 1) : null
  open_violation_on_group_overlap = lower(lookup(each.value, "type", "static")) == "outlier" ? lookup(each.value, "open_violation_on_group_overlap", null) : null

  nrql {
    query             = each.value.query
    evaluation_offset = lookup(each.value, "evaluation_offset", 3)
  }

  critical {
    operator              = lower(lookup(each.value, "type", "static")) == "outlier" ? "above" : lookup(each.value, "critical_operator", null)
    threshold             = each.value.critical_threshold
    threshold_duration    = each.value.critical_threshold_duration
    threshold_occurrences = each.value.critical_threshold_occurrences
  }
}