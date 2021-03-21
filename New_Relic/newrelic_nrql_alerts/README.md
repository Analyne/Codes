# Terraform Module `newrelic_nrql_alerts`

## Version: 1.0.0

### Terraform Syntax 0.13

This module has been created with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.

## Features

This Terraform module deploys [NRQL Alert Conditions](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/alert-conditions/create-nrql-alert-conditions "New Relic Documentation") in New Relic with the following characteristics:

* Create zero or more NRQL Alert Conditions.
* Customizable critical threshold and duration for each condition.
* Add runbook URL to each condition.

## Usage

* Changing the `app_name`, or `alert_policy_id` will cause all alerts to be destroyed then recreated. (historical alert data would be lost).

```hcl
provider "newrelic" {}

resource "newrelic_alert_policy" "example" {
  name = "example_policy"
}

module "newrelic_nrql_alerts" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_nrql_alerts/v1.0.0"

  app_name        = "example_app"
  alert_policy_id = newrelic_alert_policy.example.id

  nrql_alert_conditions = {
    "static_example" = {
      type                            = "static"
      description                     = "Alert when transactions are taking too long"
      runbook_url                     = "https://www.example.com"
      violation_time_limit_seconds    = 3600
      value_function                  = "single_value"
      query                           = "SELECT average(duration) FROM Transaction where appName = 'ExampleAppName'"
      evaluation_offset               = 3
      fill_option                     = "static"
      fill_value                      = 1.0
      aggregation_window              = 60
      expiration_duration             = 120
      open_violation_on_expiration    = true
      close_violations_on_expiration  = true
      critical_threshold              = 5.5
      critical_operator               = "above"
      critical_threshold_duration     = 300
      critical_threshold_occurrences  = "all"
    }
    "baseline_example" = {
      type                            = "baseline"
      description                     = "Alert when transactions are taking too long"
      runbook_url                     = "https://www.example.com"
      violation_time_limit_seconds    = 3600
      baseline_direction              = "upper_only"
      query                           = "SELECT percentile(duration, 95) FROM Transaction WHERE appName = 'ExampleAppName' FACET host"
      evaluation_offset               = 3
      fill_option                     = "static"
      fill_value                      = 1.0
      critical_operator               = "above"
      critical_threshold              = 5.5
      critical_threshold_duration     = 300
      critical_threshold_occurrences  = "all"
    }
    "outlier_example" = {
      type                            = "outlier"
      description                     = "Alert when outlier conditions occur"
      runbook_url                     = "https://www.example.com"
      violation_time_limit_seconds    = 3600
      expected_groups                 = 2
      open_violation_on_group_overlap = true
      query                           = "SELECT percentile(duration, 95) FROM Transaction WHERE appName = 'ExampleAppName'"
      evaluation_offset               = 3
      fill_option                     = "static"
      fill_value                      = 1.0
      critical_operator               = "above"
      critical_threshold              = 0.002
      critical_threshold_duration     = 600
      critical_threshold_occurrences  = "all"
    }
  }
}
```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**app_name** `string`

Description: Used for naming in each condition. Recommended to use APM application name.

**alert_policy_id** `string`

Description: ID of alert policy to associate alerts with.

**nrql_alert_conditions** `any`

Description: (Required) Object mapping for defining one or more NRQL condition settings. The keys should be the title of the condition (each key must be unique, combines with app_name).

&nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

* **description** `string`

  Description: (Optional) The description of the NRQL alert condition.

* **type** `string`

  Description: (Optional) The type of the condition. Valid values are `static`, `baseline`, or `outlier`. Defaults to `static`.

* **runbook_url** `string`

  Description: (Optional) Runbook URL to display in notifications.

* **enabled** `bool`

  Description:  (Optional) Whether to enable the alert condition. Valid values are `true` and `false`. Defaults to `true`.

* **violation_time_limit_seconds** `number`

  Description: (Optional) Sets a time limit, in seconds, that will automatically force-close a long-lasting violation after the time limit you select. The value must be between 300 seconds (5 minutes) to 2592000 seconds (30 days) (inclusive). Defaults to 86400 (24 hours).

* **value_function** `string`

  Description: (Required if type is `static`, optional when type is `baseline` or `outlier`) Possible values are `single_value`, `sum` (case insensitive).

* **fill_option** `string`

  Description: (Optional) Which strategy to use when filling gaps in the signal. Possible values are `none`, `last_value` or `static`. If `static`, the `fill_value` field will be used for filling gaps in the signal.

* **fill_value** `number`

  Description: (Optional, required when `fill_option` is `static`) This value will be used for filling gaps in the signal.

* **aggregation_window** `number`

  Description: (Optional) The duration of the time window used to evaluate the NRQL query, in seconds. The value must be at least 30 seconds, and no more than 15 minutes (900 seconds). Default is 60 seconds.

* **expiration_duration** `number`

  Description: (Optional) The amount of time (in seconds) to wait before considering the signal expired.

* **open_violation_on_expiration** `bool`

  Description: (Optional) Whether to create a new violation to capture that the signal expired.

* **close_violations_on_expiration** `bool`

  Description: (Optional) Whether to close all open violations when the signal expires.

* **baseline_direction** `string`

  Description: (Optional) The baseline direction of a `baseline` NRQL alert condition. Valid values are: `lower_only`, `upper_and_lower`, `upper_only` (case insensitive).

* **expected_groups** `number`

  Description: (Optional) Number of expected groups when using `outlier` detection. Defaults to `1`.

* **open_violation_on_group_overlap** `bool`

  Description: (Optional) Whether or not to trigger a violation when groups overlap. Set to `true` if you want to trigger a violation when groups overlap. This argument is only applicable in `outlier` conditions.

* **query** `string`

  Description: (Required) The NRQL query to execute for the condition.

* **evaluation_offset** `string`

  Description: (Optional) Represented in minutes and must be within 1-20 minutes (inclusive). NRQL queries are evaluated in one-minute time windows. The start time depends on this value. It's recommended to set this to 3 minutes. An offset of less than 3 minutes will trigger violations sooner, but you may see more false positives and negatives due to data latency. With `evaluation_offset` set to 3 minutes, the NRQL time window applied to your query will be: `SINCE 3 minutes ago UNTIL 2 minutes ago`.

* **critical_operator** `string`

  Description: (Optional) Valid values are `above`, `below`, or `equals` (case insensitive). Defaults to `equals` for `static` and `baseline`. Note that when using a `type` of `outlier`, the only valid option here is `above` (the module automatically sets the value to `above` when `type` is `outlier` but can be manually specified also for self-documenting purposes).

* **critical_threshold** `number`

  Description: (Required) The value which will trigger a violation. Must be `0` or greater.

* **critical_threshold_duration** `number`

  Description: (Required) The duration of time, in seconds, that the threshold must violate for in order to create a violation. Value must be a multiple of 60.

  For `baseline` NRQL alert conditions, the value must be within 120-3600 seconds (inclusive).

  For `static` NRQL alert conditions, the value must be within 120-7200 seconds (inclusive).

* **critical_threshold_occurrences** `string`

  Description: (Optional) The criteria for how many data points must be in violation for the specified threshold duration. Valid values are: `all` or `at_least_once` (case insensitive).

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

N/A

## Outputs

N/A

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

This module defines 1 resource(s):

* `newrelic_nrql_alert_condition.nrql_alert_condition`
