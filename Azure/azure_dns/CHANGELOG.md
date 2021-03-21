# Module Changelog `azure_dns`

## 1.1.0 (Unreleased)

ENHANCEMENTS:

* resource/azurerm_dns_a_record: add support for `target_resource_id` ([#17](https://github.cerner.com/CSM/terraform_registry/issues/17))
* resource/azurerm_dns_aaaa_record: add support for `target_resource_id` ([#17](https://github.cerner.com/CSM/terraform_registry/issues/17))
* resource/azurerm_dns_cname_record: add support for `target_resource_id` ([#17](https://github.cerner.com/CSM/terraform_registry/issues/17))

## 1.0.0 (May 29, 2020)

NOTES:

* Initial module version

FEATURES:

* **New Data Source** `azurerm_resource_group` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_zone` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_a_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_aaaa_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_caa_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_cname_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_mx_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_ns_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_ptr_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_srv_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_dns_txt_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_zone` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_a_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_aaaa_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_cname_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_mx_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_ptr_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_srv_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Resource** `azurerm_private_dns_txt_record` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Input** `resource_group_name` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Input** `dns_zones_and_records` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Input** `tags` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Input** `auto_tags` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
* **New Output** `public_zone_name_servers` ([#14](https://github.cerner.com/CSM/terraform_registry/pull/14))
