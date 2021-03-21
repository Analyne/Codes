# Terraform Module `newrelic_alert_policy_and_channels`

## Version: 2.1.0

### Terraform Syntax 0.13

This module has been created with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.

## Features

This Terraform module deploys an [Alert Policy](https://docs.newrelic.com/docs/alerts/new-relic-alerts/alert-policies "New Relic Documentation") and [Alert Channels](https://docs.newrelic.com/docs/alerts/new-relic-alerts/notifications "New Relic Documentation") for the policy in New Relic with the following characteristics:

* Create an Alert Policy and set incident preference.
* Define zero or more alert channels for the policy with support for email, webhook and slack configurations.

## Usage

* Changing the `app_name` will cause all resources to be destroyed then recreated (this includes any alert conditions attached to the policy).

```hcl
terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.10.2"
    }
  }
  required_version = ">= 0.13.0"
}

provider "newrelic" {
  version = "~>2.10.0"
}

module "newrelic_alert_policy_and_channels" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_alert_policy_and_channels/v1.0.0"

  app_name               = "example_app"
  alert_channel_settings = {
   "example_email_channel" = {
     channel_type                  = "email"
     email_recipients              = "example0@example.com, example1@example.com"
     # json attachment object is optional and can be omitted entirely.
     email_include_json_attachment = 0
   }
   "example_webhook_channel" = {
     channel_type                  = "webhook"
     webhook_base_url              = "https://www.example.com"
   }
   "example_slack_channel" = {
     channel_type                  = "slack"
     slack_url                     = "https://<YourOrganization>.slack.com"
     slack_channel                 = "example-alerts-channel"
   }
  }
}

output "alert_policy_id" {
  value = element(module.newrelic_alert_policy_and_channels.alert_policy_id, 0)
}
```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**app_name** `string`

Description: Used for naming policy and channels. Recommended to use APM application name.

**alert_channel_settings** `map(object)`

Description: Object Mapping of alert channels. **Map Keys** are used in the name of the respective channel.

&nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

* **channel_type** `string`

  Description: (Required) The type of alert channel to create. Supported types are `email`, `webhook`, and `slack`.

* **email_recipients** `string`

  Description: (Optional) Comma delimited string of email addresses. Required if `channel_type` is `email`.

* **email_include_json_attachment** `number`

  Description: (Optional) `0` or `1`. Flag for whether or not to attach a JSON document containing information about the associated alert to the email that is sent to recipients.

* **webhook_base_url** `string`

  Description: (Optional) The base URL of the webhook destination. Required if `channel_type` is `webhook`.

* **webhook_payload_type** `string`

  Description: (Optional) Change the default payload type for a specific webhook. Only `application/json` is supported in this version.

* **webhook_payload_string** `string`

  Description: (Optional) Change the default payload string for a specific webhook. The value provided should be a valid JSON string with escaped double quotes.

* **slack_url** `string`

  Description: (Optional) Your organization's Slack URL. Required if `channel_type` is `slack`.

* **slack_channel** `string`

  Description: (Optional) The Slack channel to send notifications to. Required if `channel_type` is `slack`.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**webhook_payload_type** `string`

Description: (Optional) Only `application/json` is supported in this version.

**webhook_payload_string** `string`

Description: (Optional) The payload that will be sent to the webhook destination. The value provided should be a valid JSON string with escaped double quotes. Value applies to all webhooks unless `webhook_payload_string` object is specified on a specific webhook.

## Outputs

**alert_policy_id** `list(string)`

Description: List of alert policy IDs. Only one alert policy is created, value is output as a `list(string)` type due to use of count to conditionally create the resource.

## Dependencies

Dependencies are external modules that this module references. A module is considered external if it isn't within the same repository.

**This module has no external module dependencies.**

### Module Dependencies

Providers are Terraform plugins that will be automatically installed during `terraform init` if available on the Terraform Registry.

* [newrelic](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs "Terraform Documentation")

## Resources and Data Sources

This is the list of resources/data sources that the module may create. The module can create zero or more of each of these resources/data sources depending on how many keys are defined. `for_each` and/or `count` values are determined at runtime. The goal of this section is to present the types of resources/data sources that may be created.

This list contains all of the resources/data sources this module plus any submodules may create. When using this module, it may create less resources if you use a submodule.

This module defines 0 data source(s):

This module defines 3 resource(s):

* `newrelic_alert_policy.alert_policy`
* `newrelic_alert_channel.alert_channel`
* `newrelic_alert_policy_channel.alert_policy_channel`
