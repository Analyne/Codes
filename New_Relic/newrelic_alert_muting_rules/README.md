# Terraform Module `newrelic_alert_muting_rules`

## Version: 1.0.0

### Terraform Syntax 0.13

This module has been created with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.

### Minimum New Relic Provider Version

The minimum required version of the new relic provider for resources in this module is 2.18.0.

## Features

This Terraform module deploys [Alert Muting Rules](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/alert-notifications/muting-rules-suppress-notifications "New Relic Documentation") in New Relic with the following characteristics:

* Create zero or more Alert Muting Rules.

## Usage

* Changing the `policy_name` or `account_id` will cause all rules to be destroyed then recreated using the new values.

* Changing the key for a rule definition will cause the corresponding rule to be destroyed/recreated using the new value.

```hcl
terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=2.18.0"
    }
  }
  required_version = ">= 0.13.0"
}

provider "newrelic" {}

resource "newrelic_alert_policy" "example" {
  name = "example_policy"
}

module "newrelic_alert_muting_rules" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_alert_muting_rules/v1.0.0"

  policy_name        = newrelic_alert_policy.example.name
  
  # Example to mute all APM alerts for a specific
  # alert policy between 12AM-1AM CST every week
  # on Mon, Wed, Fri for 52 weeks.
  alert_muting_rules = {
    "ExampleRule" = {
      enabled     = true
      description = "Example muting rule"
      conditions = [
        {
          attribute = "policyName"
          operator  = "EQUALS"
          values    = ["example_alert-policy"]
        },
        {
          attribute = "product"
          operator  = "EQUALS"
          values    = ["APM"]
        }
      ]
      operator = "AND"
      schedule = {
        start_time         = "2021-01-01T00:00:00"
        end_time           = "2021-01-01T01:00:00"
        time_zone          = "America/Chicago"
        repeat             = "WEEKLY"
        repeat_count       = 52
        weekly_repeat_days = ["MONDAY", "WEDNESDAY", "FRIDAY"]
      }
    }
  }
}
```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**policy_name** `string`

Description: (Required) Used for naming in each rule.

**account_id** `string`

Description: (Required) The New Relic account ID of the alert muting rule(s). The `NEW_RELIC_ACCOUNT_ID` environment variable can also be used.

**alert_muting_rules** `any`

Description: (Required) Object mapping for defining one or more alert muting rule settings. The keys should be the title of each rule (each key must be unique, combines with `policy_name`).

&nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

* **enabled** `bool`

  Description:  (Optional) Whether to enable the alert condition. Valid values are `true` and `false`. Defaults to `true`.

* **description** `string`

  Description: (Optional) The description of the alert muting rule.

* **conditions** `list(object)`

  Description: (Required) List of object blocks for the individual alert muting rules within the group.

  &nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

  * **attribute** `string`

    Description: (Required) The attribute on a violation. See [violation event attributes](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/alert-violations/violation-event-attributes/ "New Relic Documentation") for available attributes.
  
  * **operator** `string`

    Description: (Required) The operator used to compare the attribute's value with the supplied value(s). See [sub-condition operators](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/alert-notifications/muting-rules-suppress-notifications/#sub-conditions "New Relic Documentation") for available options.

  * **values** `list(string)`

    Description: (Required) The value(s) to compare against the attribute's value.

* **operator** `string`

  Description: (Optional) The operator used to combine all the `conditions` within the group. Valid options are `"AND"` or `"OR"`. Defaults to `"AND"`.

* **schedule** `object`

  Description: (Optional) Specify a schedule for enabling the alert muting rule.

  &nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

  * **start_time** `string`

    Description: (Optional) The datetime stamp that represents when the alert muting rule starts. This is in local ISO 8601 format without an offset. Example: `"2021-03-08T14:30:00"`

  * **end_time** `string`

    Description: (Optional) The datetime stamp that represents when the alert muting rule ends. This is in local ISO 8601 format without an offset. Example: `"2021-03-08T15:00:00"`

  * **time_zone** `string`

    Description: (Optional) The time zone that applies to the alert muting rule schedule. Example: `"America/Chicago"`. See [https://en.wikipedia.org/wiki/List_of_tz_database_time_zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

  * **repeat** `string`

    Description: (Optional) The frequency the alert muting rule schedule repeats. If it does not repeat, omit this field. Options are `"DAILY"`, `"WEEKLY"`, `"MONTHLY"`

  * **end_repeat** `string`

    Description: (Optional) The datetime stamp when the alert muting rule schedule stops repeating. This is in local ISO 8601 format without an offset. Example: `"2021-03-12T15:00:00"`. Conflicts with `repeat_count`

  * **repeat_count** `number`

    Description: (Optional) The number of times the alert muting rule schedule repeats. This includes the original schedule. For example, a repeatCount of `2` will recur one time. Conflicts with `end_repeat`

  * **weekly_repeat_days** `list(string)`

    Description: (Optional) The day(s) of the week that a alert muting rule should repeat when the repeat field is set to `"WEEKLY"`. Example: `["MONDAY", "WEDNESDAY", "FRIDAY"]`

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

* `newrelic_alert_muting_rule.alert_muting_rule`
