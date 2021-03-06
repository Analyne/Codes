### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates New Relic Alert Policies, Channels and adds the channels to the policy.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/newrelic/r/alert_policy.html
# https://www.terraform.io/docs/providers/newrelic/r/alert_channel.html
# https://www.terraform.io/docs/providers/newrelic/r/alert_policy_channel.html
# ----------------------------------------------------------------------------------------------------------------------

resource "newrelic_alert_policy" "alert_policy" {
  count = var.app_name != null ? 1 : 0

  name                = "${var.app_name}_alert-policy"
  incident_preference = var.incident_preference
}

resource "newrelic_alert_channel" "alert_channel" {
  for_each = var.alert_channel_settings

  name = "${var.app_name}_${each.key}"
  type = each.value.channel_type

  config {
    ### email config ###
    recipients              = each.value.channel_type == "email" ? each.value.email_recipients : null
    include_json_attachment = each.value.channel_type == "email" ? each.value.email_include_json_attachment : null
    ### webhook config ###
    base_url       = each.value.channel_type == "webhook" ? each.value.webhook_base_url : null
    payload_type   = each.value.channel_type == "webhook" ? var.webhook_payload_type : null
    payload_string = each.value.channel_type == "webhook" ? var.webhook_payload_string : null
    ### slack config ###
    url     = each.value.channel_type == "slack" ? each.value.slack_url : null
    channel = each.value.channel_type == "slack" ? each.value.slack_channel : null
  }
}

resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  count = length(keys(var.alert_channel_settings)) != 0 ? 1 : 0

  policy_id   = newrelic_alert_policy.alert_policy[0].id
  channel_ids = values(newrelic_alert_channel.alert_channel)[*].id
}