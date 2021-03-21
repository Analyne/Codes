# Terraform Module `newrelic_alert_conditions`

## Version: 1.1.0

### Terraform Syntax 0.12

This module has been created with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.

## Features

This Terraform module deploys [APM Alert Conditions](https://docs.newrelic.com/docs/alerts/new-relic-alerts/defining-conditions "New Relic Documentation") in New Relic with the following characteristics:

* Create zero or more APM Alert Conditions.
* Support for apdex_score, error_percentage, response_time_web, and throughput_web conditions.
* Customizable critical threshold and duration for each condition.
* Add runbook URL to each condition.

## Usage

* Changing the `app_name` or `alert_policy_id` will cause all alerts to be destroyed then recreated (historical alert data would be lost).

```hcl
provider "newrelic" {}

resource "newrelic_alert_policy" "example" {
  name = "example_policy"
}

module "newrelic_alert_conditions" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_alert_conditions/v1.0.0"

  app_name        = "example_app"
  alert_policy_id = newrelic_alert_policy.example.id

  enable_alerts = {
  low_apdex_score        = true
  high_error_percentage  = true
  high_response_time_web = true
  low_throughput_web     = true
}

apdex_score_settings = {
  duration    = 10
  threshold   = "0.75"
  runbook_url = "example.com"
}

error_percentage_settings = {
  duration    = 10
  threshold   = "5"
  runbook_url = "example.com"
}

response_time_web_settings = {
  duration  = 10
  threshold = "5"
  runbook_url = "example.com"
}

throughput_web_settings = {
  duration    = 10
  threshold   = "50"
  runbook_url = "example.com"
}
```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

All variables in this module have default values, however not setting `app_name` will cause the module to fail. Also, not setting `alert_policy_id` will cause all other resources to fail, and `enable_alerts` requires at least one object set to **True** or no resources will be created.

**app_name** `string`

Description: APM application name - must be exactly the same as displayed in APM.

**alert_policy_id** `string`

Description: ID of alert policy to associate conditions with.

**enable_alerts** `object`

Description: Boolean objects to decide which conditions to create.

Required Objects:

* **low_apdex_score** `bool`

  Description: True/False to create or not create the `newrelic_alert_condition.apdex_score` resource.

* **high_error_percentage** `bool`

  Description: True/False to create or not create the `newrelic_alert_condition.error_percentage` resource.

* **high_response_time_web** `bool`

  Description: True/False to create or not create the `newrelic_alert_condition.response_time_web` resource.

* **low_throughput_web** `bool`

  Description: True/False to create or not create the `newrelic_alert_condition.throughput_web` resource.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**apdex_score_settings** `object`

Description: `newrelic_alert_condition.apdex_score` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the apdex score must fall below to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**error_percentage_settings** `object`

Description: `newrelic_alert_condition.error_percentage` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the error percentage must be above to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**response_time_web_settings** `object`

Description: `newrelic_alert_condition.response_time_web` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the web response time must be above to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**throughput_web_settings** `object`

Description: `newrelic_alert_condition.throughput_web` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the web throughput must be below to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

## Outputs

N/A

## Dependencies

Dependencies are external modules that this module references. A module is considered external if it isn't within the same repository.

**This module has no external module dependencies.**

### Module Dependencies

Providers are Terraform plugins that will be automatically installed during `terraform init` if available on the Terraform Registry.

* [newrelic](https://www.terraform.io/docs/providers/newrelic/index.html "Terraform Documentation")

## Resources and Data Sources

This is the list of resources/data sources that the module may create. The module can create zero or more of each of these resources/data sources depending on how many keys are defined. `for_each` and/or `count` values are determined at runtime. The goal of this section is to present the types of resources/data sources that may be created.

This list contains all of the resources/data sources this module plus any submodules may create. When using this module, it may create less resources if you use a submodule.

This module defines 1 data source(s):

* `newrelic_application.apm-app`

This module defines 4 resource(s):

* `newrelic_alert_condition.apdex_score`
* `newrelic_alert_condition.error_percentage`
* `newrelic_alert_condition.response_time_web`
* `newrelic_alert_condition.throughput_web`
