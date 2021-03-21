# Terraform Module `newrelic_synthetics_monitor`

## Version: 1.0.0

### Terraform Syntax 0.12

This module has been created with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.

## Features

This Terraform module deploys [New Relic Synthetics](https://docs.newrelic.com/docs/synthetics/new-relic-synthetics "New Relic Documentation") in New Relic with the following characteristics:

* Create zero or more Synthetic monitors.
* Support for simple and browser synthetic monitors.
* Optional alert condition for each synthetic monitor.

## Usage

* Changing the `app_name` will cause all monitors to be destroyed then recreated (historical alert data would be lost).

```hcl
provider "newrelic" {}

resource "newrelic_alert_policy" "example" {
  name = "example_policy"
}

module "newrelic_synthetics_monitor" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//New_Relic/newrelic_synthetics_monitor/v1.0.0"

  app_name        = "example_app"
  alert_policy_id = newrelic_alert_policy.example.id

  synthetic_monitor_settings = {
    "www.example.com_simple" = {
      uri                       = "https://www.example.com"
      type                      = "SIMPLE"
      frequency                 = 10
      status                    = "ENABLED"
      locations                 = ["AWS_US_EAST_1", "2427582-usa_kansas_city_viii-E3F"]
      sla_threshold             = null
      validation_string         = "some text to scrape"
      verify_ssl                = true
      bypass_head_request       = false
      treat_redirect_as_failure = true
      enable_alert_condition    = true
      runbook_url               = "example.com"
    }
    "www.example.com_browser" = {
      uri                       = "https://www.example.com"
      type                      = "BROWSER"
      frequency                 = 10
      status                    = "ENABLED"
      locations                 = ["AWS_US_EAST_1", "2427582-usa_kansas_city_viii-E3F"]
      sla_threshold             = 10
      validation_string         = "some text to scrape"
      verify_ssl                = true
      bypass_head_request       = null
      treat_redirect_as_failure = null
      enable_alert_condition    = true
      runbook_url               = "example.com"
    }
  }
}

```

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**app_name** `string`

Description: Used for naming in each condition. Recommended to use APM application name.

**synthetic_monitor_settings** `map(object)`

Description: Object mapping to create zero or more synthetic monitors. Only simple and browser types are supported (No scripted types). **Key values** are used in the monitor name. Set optional values to `null` if not desired.

Required Objects:

* **uri** `string`

  Description: (Required) The URI that the monitor will check.

* **type** `string`

  Description: (Required) The type of monitor. Valid values are `SIMPLE` or `BROWSER`.

* **frequency** `number`

  Description: (Required) The interval (in minutes) at which this monitor should run.

* **status** `string`

  Description: (Required) The monitor status (`ENABLED`, `MUTED`, `DISABLED`).

* **locations** `list(string)`

  Description: (Required) The locations in which this monitor should be run. Public locations are hosted by New Relic and go over the internet, private locations are hosted on Cerner's internal network.

  When listing locations in config, use the value from **Name** column in the table below.
  
  Current list of valid locations (06/17/2020):
  
  | Private | Name                                     | Label                        |
  | ------- | ---------------------------------------- | ---------------------------- |
  | False   | AWS_US_EAST_1                            | Washington, DC, USA          |
  | False   | AWS_US_EAST_2                            | Columbus, OH, USA            |
  | False   | AWS_US_WEST_1                            | San Francisco, CA, USA       |
  | False   | AWS_US_WEST_2                            | Portland, OR, USA            |
  | False   | AWS_CA_CENTRAL_1                         | Montreal, QuÃ©bec, CA        |
  | False   | AWS_EU_WEST_1                            | Dublin, IE                   |
  | False   | AWS_EU_WEST_2                            | London, England, UK          |
  | False   | AWS_EU_WEST_3                            | Paris, FR                    |
  | False   | AWS_EU_CENTRAL_1                         | Frankfurt, DE                |
  | False   | AWS_EU_NORTH_1                           | Stockholm, SE                |
  | False   | AWS_EU_SOUTH_1                           | Milan, IT                    |
  | False   | AWS_AP_NORTHEAST_1                       | Tokyo, JP                    |
  | False   | AWS_AP_NORTHEAST_2                       | Seoul, KR                    |
  | False   | AWS_AP_SOUTHEAST_1                       | Singapore, SG                |
  | False   | AWS_AP_SOUTHEAST_2                       | Sydney, AU                   |
  | False   | AWS_AP_SOUTH_1                           | Mumbai, IN                   |
  | False   | AWS_AP_EAST_1                            | Hong Kong, HK                |
  | False   | AWS_SA_EAST_1                            | SÃ£o Paulo, BR               |
  | False   | AWS_ME_SOUTH_1                           | Manama, BH                   |
  | False   | AWS_AF_SOUTH_1                           | Cape Town, ZA                |
  | True    | 2427582-india_bangalore_h2-520           | India Bangalore H2           |
  | True    | 2427582-usa_kansas_city_viii-E3F         | USA Kansas City VIII         |
  | True    | 2427582-australia_melbourne_corpmelb-97A | Australia Melbourne CORPMELB |
  | True    | 2427582-uk_corpuk-C2C                    | UK CORPUK                    |
  | True    | 2427582-sweden_corpgoth-599              | Sweden CORPGOTH              |
  | True    | 2427582-australia_brisbane_corpbris-72C  | Australia Brisbane CORPBRIS  |
  | True    | 2427582-australia_sydney_corpsyd-ADE     | Australia Sydney CORPSYD     |
  | True    | 2427582-spain_corpmad-2C4                | Spain CORPMAD                |
  | True    | 2427582-romania_corpbras-AE0             | Romania CORPBRAS             |
  | True    | 2427582-netherland_corphagu-3E           | Netherland CORPHAGU          |
  | True    | 2427582-ireland_corpdub-C0B              | Ireland CORPDUB              |
  | True    | 2427582-france_corpprs-627               | France CORPPRS               |
  | True    | 2427582-austria_corpvien-6C6             | Austria CORPVIEN             |
  | True    | 2427582-uae_corpuae-F1E                  | UAE CORPUAE                  |
  | True    | 2427582-india_bangalore_gtp-8A8          | India Bangalore GTP          |
  | True    | 2427582-india_bangalore_north_gate-1A9   | India Bangalore North Gate   |
  | True    | 2427582-india_kolkata-AAF                | India Kolkata                |
  | True    | 2427582-india_bangalore_c2-63E           | India Bangalore_C2           |

* **sla_threshold** `number`

  Description: (Optional) The base threshold for the SLA report. Defaults to 7 if set to `null`.

* **validation_string** `string`

  Description: (Optional) The string to validate against in the response.

* **verify_ssl** `bool`

  Description: (Optional) Verify SSL.

* **bypass_head_request** `bool`

  Description: (Optional) Bypass HEAD request. For SIMPLE type only.

* **treat_redirect_as_failure** `bool`

  Description: (Optional) Fail the monitor check if redirected. For SIMPLE type only.

* **enable_alert_condition** `bool`

  Description: (Required) Enable or disable alert condition.

* **runbook_url** `string`

  Description: (Optional) URL for the runbook to follow for this alert condition. Requires `alert_policy_id` to be set.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**alert_policy_id** `string`

Description: ID of alert policy to associate alerts with. Required if setting `enable_alert_condition` to **True**.

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

This module defines 0 data source(s):

This module defines 2 resource(s):

* `newrelic_synthetics_monitor.synthetics_monitor`
* `newrelic_synthetics_alert_condition.synthetics_alert`
