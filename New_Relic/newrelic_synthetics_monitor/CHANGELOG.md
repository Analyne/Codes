# Module Changelog `newrelic_synthetics_monitor`

## 2.0.0 (January 12, 2020)

NOTES:

* Terraform version 0.13 upgrade. Added required providers block to support Terraform version 0.13. See [Upgrading to Terraform v0.13 - Explicit Provider Source Locations](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations "Terraform Documentation") for additional information ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Added support for `SCRIPT_BROWSER` and `SCRIPT_API` types ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Changed resource and variable object references to allow for optional arguments ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Minimum New Relic provider version is now 2.13.0 ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

FEATURES:

* **New Resource** `newrelic_synthetics_monitor_script.synthetics_script` ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

## 1.0.0 (April 17, 2020)

NOTES:

* Initial module version ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))

FEATURES:

* **New Resource** `newrelic_synthetics_monitor` ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))
* **New Resource** `newrelic_synthetics_alert_condition` ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))
* **New Input** `app_name` ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))
* **New Input** `alert_policy_id` ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))
* **New Input** `synthetic_monitor_settings` ([#10](https://github.cerner.com/CSM/terraform_registry/pull/10))
