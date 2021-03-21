# Terraform Module `newrelic_infra_alerts`

## Version: 2.0.0

### Terraform Syntax 0.13

This module has been created with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.

## Features

This Terraform module deploys [Infrastructure Alert Conditions](https://docs.newrelic.com/docs/alerts/new-relic-alerts/defining-conditions "New Relic Documentation") in New Relic with the following characteristics:

* Create zero or more Infrastructure Alert Conditions.
* Support for low_disk_space, high_processor_usage, high_memory_usage, host_not_reporting, and process_not_running conditions.
* Customizable critical threshold and duration for each condition.
* Add runbook URL to each condition.

## Usage

* Changing the `app_name` or `alert_policy_id` will cause all alerts to be destroyed then recreated (historical alert data would be lost).

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
  version = "~>2.10.2"
}

resource "newrelic_alert_policy" "example" {
  name = "example_policy"
}

module "newrelic_infra_alerts" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_infra_alerts/v1.0.0"

  app_name        = "example_app"
  alert_policy_id = newrelic_alert_policy.example.id

  hostname_filter = "(`hostname` LIKE '%examplehostname%')"
  
  enable_alerts   = {
    low_disk_space     = false
    high_cpu_usage     = false
    high_memory_usage  = false
    host_not_reporting = false
  }

  low_disk_space_settings = {
    duration    = 10
    threshold   = 90
    runbook_url = "example.com"
  }
  
  high_cpu_usage_settings = {
    duration    = 10
    threshold   = 90
    runbook_url = "example.com"  
  }

  high_memory_usage_settings = {
    duration    = 10
    threshold   = 90
    runbook_url = "example.com"
  }

  host_not_reporting_settings = {
    duration    = 10  
    runbook_url = "example.com"
  }

  process_monitor_settings = {
    "example_process0" = {
      hostname_filter = "(`hostname` LIKE '%examplehostname%')"
      process_filter  = "`processDisplayName` = 'example.exe'"
      duration        = 10
      runbook_url     = "example.com"
    }
    "example_process1" = {
      hostname_filter = "(`hostname` LIKE '%examplehostname%')"
      process_filter  = "`commandName` = '/usr/bin/java'"
      duration        = 10
      runbook_url     = "example.com"
    }
  }
}
```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

All variables in this module have default values, however not setting `app_name` will cause the module to fail. Also, not setting `alert_policy_id` and `hostname_filter` will cause all other resources to fail, and `enable_alerts` requires at least one object set to **True** or no resources will be created.

**app_name** `string`

Description: Used for naming in each condition. Recommended to use APM application name.

**alert_policy_id** `string`

Description: ID of alert policy to associate alerts with.

**hostname_filter** `string`

Description: `WHERE` clause to filter hostnames for which to apply alert conditions. Refer to example above and [NRQL syntax documentation](https://docs.newrelic.com/docs/query-data/nrql-new-relic-query-language/getting-started/nrql-syntax-clauses-functions#sel-where "New Relic Documentation").

**enable_alerts** `object`

Description: Boolean objects to decide which conditions to create.

Required Objects:

* **low_disk_space** `bool`

  Description: True/False to create or not create the `newrelic_infra_alert_condition.low_disk_space` resource.

* **high_cpu_usage** `bool`

  Description: True/False to create or not create the `newrelic_infra_alert_condition.high_cpu_usage` resource.

* **high_memory_usage** `bool`

  Description: True/False to create or not create the `newrelic_infra_alert_condition.high_memory_usage` resource.

* **host_not_reporting** `bool`

  Description: True/False to create or not create the `newrelic_infra_alert_condition.host_not_reporting` resource.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**low_disk_space_settings** `object`

Description: `newrelic_infra_alert_condition.low_disk_space` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the disk space percentage must be above to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**high_cpu_usage_settings** `object`

Description: `newrelic_infra_alert_condition.high_cpu_usage` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the CPU usage must be above to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**high_memory_usage_settings** `object`

Description: `newrelic_infra_alert_condition.high_memory_usage` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **threshold** `string`

  Description: Threshold that the memory usage must be above to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**host_not_reporting_settings** `object`

Description: `newrelic_infra_alert_condition.host_not_reporting` critical threshold and duration settings.

Required Objects:

* **duration** `number`

  Description: Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **runbook_url** `string`

  Description: URL for the runbook to follow for this alert condition.

**process_monitor_settings** `map(object)`

Description: `newrelic_infra_alert_condtion.process_monitor` object mapping. Currently only monitors for if 0 matching processes are running.

&nbsp;&nbsp;&nbsp;&nbsp;Valid Objects:

* **hostname_filter** `string`

  Description: (Required) Separate `WHERE` clause to filter hostnames to monitor processes on. Defaults to above `hostname_filter` input if not specified. Refer to example above and [NRQL syntax documentation](https://docs.newrelic.com/docs/query-data/nrql-new-relic-query-language/getting-started/nrql-syntax-clauses-functions#sel-where "New Relic Documentation").

* **process_filter** `string`

  Description: (Required) `WHERE` clause to filter for which process to monitor. Refer to example above and [NRQL syntax documentation](https://docs.newrelic.com/docs/query-data/nrql-new-relic-query-language/getting-started/nrql-syntax-clauses-functions#sel-where "New Relic Documentation").

* **duration** `number`

  Description: (Required) Duration in minutes that the condition must be in violation of the threshold to trigger an alert.

* **runbook_url** `string`

  Description: (Optional) URL for the runbook to follow for this alert condition.

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

This module defines 5 resource(s):

* `newrelic_infra_alert_condition.low_disk_space`
* `newrelic_infra_alert_condition.high_cpu_usage`
* `newrelic_infra_alert_condition.high_memory_usage`
* `newrelic_infra_alert_condition.host_not_reporting`
* `newrelic_infra_alert_condition.process_not_running`
