### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic infrastructure alert conditions.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/infra_alert_condition.html
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_infra_alert_condition" "low_disk_space" {
  count = var.enable_alerts.low_disk_space ? 1 : 0

  policy_id = var.alert_policy_id

  name        = "${var.app_name}_low-disk-space"
  type        = "infra_metric"
  event       = "StorageSample"
  select      = "diskUsedPercent"
  comparison  = "above"
  where       = var.hostname_filter
  runbook_url = var.low_disk_space_settings.runbook_url

  critical {
    duration      = var.low_disk_space_settings.duration
    value         = var.low_disk_space_settings.threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "high_processor_usage" {
  count = var.enable_alerts.high_cpu_usage ? 1 : 0

  policy_id = var.alert_policy_id

  name        = "${var.app_name}_high-cpu-usage"
  type        = "infra_metric"
  event       = "SystemSample"
  select      = "cpuPercent"
  comparison  = "above"
  where       = var.hostname_filter
  runbook_url = var.high_cpu_usage_settings.runbook_url

  critical {
    duration      = var.high_cpu_usage_settings.duration
    value         = var.high_cpu_usage_settings.threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "high_memory_usage" {
  count = var.enable_alerts.high_memory_usage ? 1 : 0

  policy_id = var.alert_policy_id

  name        = "${var.app_name}_high-memory-usage"
  type        = "infra_metric"
  event       = "SystemSample"
  select      = "memoryUsedBytes/memoryTotalBytes*100"
  comparison  = "above"
  where       = var.hostname_filter
  runbook_url = var.high_memory_usage_settings.runbook_url

  critical {
    duration      = var.high_memory_usage_settings.duration
    value         = var.high_memory_usage_settings.threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "host_not_reporting" {
  count = var.enable_alerts.host_not_reporting ? 1 : 0

  policy_id = var.alert_policy_id

  name        = "${var.app_name}_host-not-reporting"
  type        = "infra_host_not_reporting"
  where       = var.hostname_filter
  runbook_url = var.host_not_reporting_settings.runbook_url

  critical {
    duration = var.host_not_reporting_settings.duration
  }
}

resource "newrelic_infra_alert_condition" "process_not_running" {
  for_each = var.process_monitor_settings

  policy_id = var.alert_policy_id

  name          = "${var.app_name}_process_not_running_${each.key}"
  type          = "infra_process_running"
  comparison    = "equal"
  where         = each.value.hostname_filter
  process_where = each.value.process_filter
  runbook_url   = each.value.runbook_url

  critical {
    duration = each.value.duration
    value    = 0
  }
}