### Module Version 2.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.10.2"
    }
  }
  required_version = ">= 0.13.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic Alert Conditions.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/alert_condition.html
# ----------------------------------------------------------------------------------------------------------------------

data "newrelic_application" "apm-app" {
  count  = var.app_name != "" && var.app_name != null && var.enable_alerts.low_apdex_score || var.enable_alerts.high_error_percentage || var.enable_alerts.high_response_time_web || var.enable_alerts.low_throughput_web ? 1 : 0
  name   = var.app_name
}

data "newrelic_entity" "application" {
  count  = var.app_name != "" && var.app_name != null && var.enable_alerts.low_apdex_score || var.enable_alerts.high_error_percentage || var.enable_alerts.high_response_time_web || var.enable_alerts.low_throughput_web ? 1 : 0
  name   = var.app_name == null ? "" : var.app_name
  domain = "APM"
  type   = "APPLICATION"
  tag {
    key   = "accountID"
    value = var.account_id
  }
}

resource "newrelic_alert_condition" "apdex_score" {
  count = var.app_name != "" && var.app_name != null && var.enable_alerts.low_apdex_score && local.app_id != null ? 1 : 0

  policy_id = var.alert_policy_id

  name            = "${var.app_name}_low-apdex-score"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.application[0].application_id]
  metric          = "apdex"
  runbook_url     = var.apdex_score_settings.runbook_url
  condition_scope = "application"

  term {
    priority      = "critical"
    operator      = "below"
    threshold     = var.apdex_score_settings.threshold
    duration      = var.apdex_score_settings.duration
    time_function = "all"
  }
}

resource "newrelic_alert_condition" "error_percentage" {
  count = var.app_name != "" && var.app_name != null && var.enable_alerts.high_error_percentage && local.app_id != null ? 1 : 0

  policy_id = var.alert_policy_id

  name            = "${var.app_name}_high-error-percentage"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.application[0].application_id]
  metric          = "error_percentage"
  runbook_url     = var.error_percentage_settings.runbook_url
  condition_scope = "application"

  term {
    priority      = "critical"
    operator      = "above"
    threshold     = var.error_percentage_settings.threshold
    duration      = var.error_percentage_settings.duration
    time_function = "all"
  }
}

resource "newrelic_alert_condition" "response_time_web" {
  count = var.app_name != "" && var.app_name != null && var.enable_alerts.high_response_time_web && local.app_id != null ? 1 : 0

  policy_id = var.alert_policy_id

  name            = "${var.app_name}_high-response-time-web"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.application[0].application_id]
  metric          = "response_time_web"
  runbook_url     = var.response_time_web_settings.runbook_url
  condition_scope = "application"

  term {
    priority      = "critical"
    operator      = "above"
    threshold     = var.response_time_web_settings.threshold
    duration      = var.response_time_web_settings.duration
    time_function = "all"
  }
}

resource "newrelic_alert_condition" "throughput_web" {
  count = var.app_name != "" && var.app_name != null && var.enable_alerts.low_throughput_web && local.app_id != null ? 1 : 0

  policy_id = var.alert_policy_id

  name            = "${var.app_name}_low-throughput-web"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.application[0].application_id]
  metric          = "throughput_web"
  runbook_url     = var.throughput_web_settings.runbook_url
  condition_scope = "application"

  term {
    priority      = "critical"
    operator      = "below"
    threshold     = var.throughput_web_settings.threshold
    duration      = var.throughput_web_settings.duration
    time_function = "all"
  }
}

locals {
  app_id = var.app_name != "" && var.app_name != null && var.enable_alerts.low_apdex_score || var.enable_alerts.high_error_percentage || var.enable_alerts.high_response_time_web || var.enable_alerts.low_throughput_web ? data.newrelic_entity.application[0].application_id : null
}