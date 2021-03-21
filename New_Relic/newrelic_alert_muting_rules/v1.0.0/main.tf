### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.18.0"
    }
  }
  required_version = ">= 0.13.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic Alert Muting Rules.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_muting_rule
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_alert_muting_rule" "alert_muting_rule" {
  for_each = var.alert_muting_rules

  account_id  = var.account_id
  name        = "${var.policy_name}_${each.key}_muting_rule"
  enabled     = lookup(each.value, "enabled", true)
  description = lookup(each.value, "description", null)

  condition {
    dynamic "conditions" {
      for_each = lookup(each.value, "conditions", null) != null ? each.value.conditions : []
      content {
        attribute = conditions.value.attribute
        operator  = upper(conditions.value.operator)
        values    = conditions.value.values
      }
    }
    operator = upper(lookup(each.value, "operator", "AND"))
  }

  dynamic "schedule" {
    for_each = lookup(each.value, "schedule", null) != null && lookup(each.value, "schedule", null) != {} ? [each.value.schedule] : []
    content {
      start_time         = lookup(schedule.value, "start_time", null)
      end_time           = lookup(schedule.value, "end_time", null)
      time_zone          = lookup(schedule.value, "time_zone", "America/Chicago")
      repeat             = lookup(schedule.value, "repeat", null) != null && lookup(schedule.value, "repeat", null) != "" ? upper(lookup(schedule.value, "repeat", "")) : null
      end_repeat         = lookup(schedule.value, "repeat_count", null) != null ? null : lookup(schedule.value, "end_repeat", null)
      repeat_count       = lookup(schedule.value, "end_repeat", null) != null ? null : lookup(schedule.value, "repeat_count", null)
      weekly_repeat_days = upper(lookup(schedule.value, "repeat", "")) == "WEEKLY" && lookup(schedule.value, "weekly_repeat_days", []) != null ? [for day in lookup(schedule.value, "weekly_repeat_days", []) : upper(day)] : null
    }
  }
}