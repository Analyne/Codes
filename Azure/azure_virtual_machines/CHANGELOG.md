# Module Changelog `azure_virtual_machines`

## 1.0.0

NOTES:

* Initial module version

FEATURES:

* **New Data Source** `azurerm_resource_group.resource_group`
* **New Resource** `random_id.vm_sa`
* **New Resource** `azurerm_storage_account.vm_sa`
* **New Resource** `azurerm_public_ip.vm_public_ip`
* **New Resource** `azurerm_network_interface.vm_nic`
* **New Resource** `azurerm_network_security_group.vm_nsg`
* **New Resource** `azurerm_network_interface_security_group_association.vm_nsg`
* **New Resource** `azurerm_linux_virtual_machine.vm_linux`
* **New Resource** `azurerm_windows_virtual_machine.vm_windows`
* **New Resource** `azurerm_managed_disk.vm_disk`
* **New Resource** `azurerm_virtual_machine_data_disk_attachment.vm_disk`
* **New Input** `resource_group_name`
* **New Input** `location`
* **New Input** `public_ip_sku`
* **New Input** `public_ip_allocation_method`
* **New Input** `public_ip_version`
* **New Input** `public_ip_idle_timeout`
* **New Input** `public_ip_domain_name_label`
* **New Input** `public_ip_reverse_fqdn`
* **New Input** `public_ip_prefix_id`
* **New Input** `public_ip_zones`
* **New Input** `public_ip_tags`
* **New Input** `dns_servers`
* **New Input** `enable_ip_forwarding`
* **New Input** `enable_accelerated_networking`
* **New Input** `internal_dns_name_label`
* **New Input** `nic_tags`
* **New Input** `private_ip_version`
* **New Input** `private_ip_allocation_method`
* **New Input** `private_ip_address_static`
* **New Input** `remote_port`
* **New Input** `nsg_tags`
* **New Input** `is_windows_image`
* **New Input** `vm_hostname`
* **New Input** `vm_size`
* **New Input** `admin_username`
* **New Input** `admin_password`
* **New Input** `allow_extension_operations`
* **New Input** `availability_set_id`
* **New Input** `computer_name`
* **New Input** `custom_data_file`
* **New Input** `dedicated_host_id`
* **New Input** `provision_vm_agent`
* **New Input** `vm_os_id`
* **New Input** `scale_set_id`
* **New Input** `vm_availability_zone`
* **New Input** `vm_tags`
* **New Input** `enable_ultra_ssd`
* **New Input** `os_disk_caching`
* **New Input** `os_disk_sa_type`
* **New Input** `os_disk_size_gb`
* **New Input** `os_disk_enable_write_accelerator`
* **New Input** `os_disk_ephemeral`
* **New Input** `enable_boot_diagnostics`
* **New Input** `boot_diagnostics_sa_type`
* **New Input** `managed_identity_ids`
* **New Input** `vm_os_simple`
* **New Input** `vm_os_publisher`
* **New Input** `vm_os_offer`
* **New Input** `vm_os_sku`
* **New Input** `vm_os_version`
* **New Input** `disable_password_authentication`
* **New Input** `enable_automatic_updates`
* **New Input** `license_type`
* **New Input** `proximity_placement_group_id`
* **New Input** `timezone`
* **New Input** `additional_unattended_content`
* **New Input** `data_disks`
* **New Input** `tags`
* **New Input** `auto_tags`
