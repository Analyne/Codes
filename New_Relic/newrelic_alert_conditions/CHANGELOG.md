# Module Changelog `newrelic_alert_conditions`

## 2.0.0 (January 12, 2020)

NOTES:

* Terraform version 0.13 upgrade. Added required providers block to support Terraform version 0.13. See [Upgrading to Terraform v0.13 - Explicit Provider Source Locations](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations "Terraform Documentation") for additional information ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Replaced deprecated data source ([#28](https://github.cerner.com/CSM/terraform_registry/pull/28))

* Added conditions to allow for app_name to be empty or null without failing ([#28](https://github.cerner.com/CSM/terraform_registry/pull/28))

* Minimum New Relic provider version is now 2.10.2 ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

FEATURES:

* **New Data Source** `newrelic.entity.application` ([#28](https://github.cerner.com/CSM/terraform_registry/pull/28))
* **Removed Data Source** `newrelic.application.apm-app` ([#28](https://github.cerner.com/CSM/terraform_registry/pull/28))

## 1.1.0 (June 1, 2020)

ENHANCEMENTS:

* resource/newrelic_alert_condition (all): add support for `runbook_url` ([#117](https://github.cerner.com/CSM/NewRelic/issues/117))
* input/apdex_score_settings: add `runbook_url` object. ([#117](https://github.cerner.com/CSM/NewRelic/issues/117))
* input/error_percentage_settings: add `runbook_url` object. ([#117](https://github.cerner.com/CSM/NewRelic/issues/117))
* input/response_time_web_settings: add `runbook_url` object. ([#117](https://github.cerner.com/CSM/NewRelic/issues/117))
* input/throughput_web_settings: add `runbook_url` object. ([#117](https://github.cerner.com/CSM/NewRelic/issues/117))

## 1.0.0 (March 31, 2020)

NOTES:

* Initial module version ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))

FEATURES:

* **New Data Source** `newrelic_application` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Resource** `newrelic_alert_condition` (apdex_score) ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Resource** `newrelic_alert_condition` (error_percentage) ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Resource** `newrelic_alert_condition` (response_time_web) ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Resource** `newrelic_alert_condition` (throughput_web) ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `app_name` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `alert_policy_id` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `enable_alerts` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `apdex_score_settings` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `error_percentage_settings` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `response_time_web_settings` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
* **New Input** `throughput_web_settings` ([#3](https://github.cerner.com/CSM/terraform_registry/pull/3))
