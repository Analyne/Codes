# Module Changelog `newrelic_infra_alerts`

## 2.0.0 (January 12, 2020)

NOTES:

* Terraform version 0.13 upgrade. Added required providers block to support Terraform version 0.13. See [Upgrading to Terraform v0.13 - Explicit Provider Source Locations](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations "Terraform Documentation") for additional information ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Changed process monitor resource and variable object references to allow for optional arguments ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Minimum New Relic provider version is now 2.10.2 ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

IMPROVEMENTS:

* **Resource** `newrelic_infra_alert_condition.process_not_running` - optional arguments can now be omitted completely. ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* **Input** `process_monitor_settings` - changed type from `map(object)` to `any` to allow for optional inputs. ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

## 1.0.0 (April 17, 2020)

NOTES:

* Initial module version ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))

FEATURES:

* **New Resource** `newrelic_infra_alert_condition` (low_disk_space) ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Resource** `newrelic_infra_alert_condition` (high_processor_usage) ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Resource** `newrelic_infra_alert_condition` (high_memory_usage) ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Resource** `newrelic_infra_alert_condition` (host_not_reporting) ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Resource** `newrelic_infra_alert_condition` (process_not_running) ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `app_name` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `alert_policy_id` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `hostname_filter` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `enable_alerts` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `low_disk_space_settings` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `high_cpu_usage_settings` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `high_memory_settings` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `host_not_reporting_settings` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
* **New Input** `process_monitor_settings` ([#9](https://github.cerner.com/CSM/terraform_registry/pull/9))
