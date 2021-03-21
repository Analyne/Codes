# Module Changelog `newrelic_alert_policy_and_channels`

## 2.1.0 (March 18, 2021)

## 2.0.0 (January 12, 2020)

NOTES:

* Terraform version 0.13 upgrade. Added required providers block to support Terraform version 0.13. See [Upgrading to Terraform v0.13 - Explicit Provider Source Locations](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations "Terraform Documentation") for additional information ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Changed alert channel resource and variable object references to allow for optional arguments ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* Minimum New Relic provider version is now 2.10.2 ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

IMPROVEMENTS:

* **Resource** `newrelic_alert_channel.alert_channel` - optional arguments can now be omitted completely. ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

* **Input** `alert_channel_settings` - changed type from `map(object)` to `any` to allow for optional inputs. ([#27](https://github.cerner.com/CSM/terraform_registry/pull/27))

## 1.0.1 (October 19, 2020)

NOTES:

* Added Runbook URL link to webhook notifications ([#25](https://github.cerner.com/CSM/terraform_registry/pull/25))

IMPROVEMENTS:

* **Input** `webhook_payload_string` - added Runbook URL link to webhook notifications ([#25](https://github.cerner.com/CSM/terraform_registry/pull/25))

## 1.0.0 (April 24, 2020)

NOTES:

* Initial module version ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))

FEATURES:

* **New Resource** `newrelic_alert_policy` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Resource** `newrelic_alert_channel` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Resource** `newrelic_alert_policy_channel` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Input** `app_name` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Input** `incident_preference` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Input** `alert_channel_settings` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Input** `webhook_payload_type` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Input** `webhook_payload_string` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
* **New Output** `alert_policy_id` ([#11](https://github.cerner.com/CSM/terraform_registry/pull/11))
