### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.3.0"
    }
  }
  required_version = ">= 0.13.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# This module creates Azure Virtual Machines.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/azurerm/d/resource_group.html
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html
# https://www.terraform.io/docs/providers/azurerm/r/public_ip.html
# https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
# https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html
# https://www.terraform.io/docs/providers/azurerm/r/network_interface_security_group_association.html
# https://www.terraform.io/docs/providers/azurerm/r/linux_virtual_machine.html
# https://www.terraform.io/docs/providers/azurerm/r/windows_virtual_machine.html
# https://www.terraform.io/docs/providers/azurerm/r/managed_disk.html
# https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_data_disk_attachment.html
# ----------------------------------------------------------------------------------------------------------------------

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

resource "random_id" "vm_sa" {
  count = var.enable_boot_diagnostics ? 1 : 0
  keepers = {
    vm_hostname = var.vm_hostname
  }

  byte_length = 6
}

resource "azurerm_storage_account" "vm_sa" {
  count                    = var.enable_boot_diagnostics ? 1 : 0
  name                     = "bootdiag${lower(random_id.vm_sa[count.index].hex)}"
  resource_group_name      = data.azurerm_resource_group.resource_group.name
  location                 = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  account_tier             = element(split("_", var.boot_diagnostics_sa_type), 0)
  account_replication_type = element(split("_", var.boot_diagnostics_sa_type), 1)
  tags                     = local.global_tags
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                    = "${var.vm_hostname}-publicip"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  location                = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  sku                     = var.public_ip_sku
  allocation_method       = var.public_ip_allocation_method
  ip_version              = var.public_ip_version
  idle_timeout_in_minutes = var.public_ip_idle_timeout
  domain_name_label       = var.public_ip_domain_name_label
  reverse_fqdn            = var.public_ip_reverse_fqdn
  public_ip_prefix_id     = var.public_ip_prefix_id
  zones                   = var.public_ip_zones
  tags                    = merge(local.global_tags, var.public_ip_tags)
}

resource "azurerm_network_interface" "vm_nic" {
  name                          = "${var.vm_hostname}-nic"
  resource_group_name           = data.azurerm_resource_group.resource_group.name
  location                      = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  dns_servers                   = var.dns_servers
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  internal_dns_name_label       = var.internal_dns_name_label


  ip_configuration {
    name                          = "${var.vm_hostname}-ip"
    subnet_id                     = var.private_ip_version == "IPv4" ? var.vnet_subnet_id : null
    private_ip_address_version    = var.private_ip_version
    private_ip_address_allocation = title(var.private_ip_allocation_method)
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
    # primary                       = ""
    private_ip_address = lower(var.private_ip_allocation_method) == "static" ? var.private_ip_address_static : null
  }

  tags = merge(local.global_tags, var.nic_tags)
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.vm_hostname}-nsg"
  location            = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  resource_group_name = data.azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "allow_remote_${coalesce(var.remote_port, local.calculated_remote_port)}_in_all"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = coalesce(var.remote_port, local.calculated_remote_port)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.global_tags, var.nsg_tags)
}

resource "azurerm_network_interface_security_group_association" "vm_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  count               = ! contains([lower(var.vm_os_simple), lower(var.vm_os_offer)], "windowsserver") && ! var.is_windows_image ? 1 : 0
  name                = var.vm_hostname
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]
  allow_extension_operations      = var.allow_extension_operations
  availability_set_id             = var.availability_set_id
  computer_name                   = var.computer_name
  custom_data                     = var.custom_data_file != null && var.custom_data_file != "" ? base64encode(file("${path.root}/${var.custom_data_file}")) : null
  dedicated_host_id               = var.dedicated_host_id
  disable_password_authentication = var.disable_password_authentication
  provision_vm_agent              = var.provision_vm_agent
  source_image_id                 = var.vm_os_id
  virtual_machine_scale_set_id    = var.scale_set_id
  zone                            = var.vm_availability_zone

  tags = merge(local.global_tags, var.vm_tags)

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd
  }

  dynamic admin_ssh_key {
    for_each = var.admin_ssh_public_key == null || var.admin_ssh_public_key == "" ? [] : [var.admin_ssh_public_key]
    content {
      public_key = file("${path.root}/${var.admin_ssh_public_key}")
      username   = var.admin_username
    }
  }

  os_disk {
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_sa_type
    disk_encryption_set_id    = null
    disk_size_gb              = var.os_disk_size_gb
    name                      = "${var.vm_hostname}-os_disk"
    write_accelerator_enabled = var.os_disk_enable_write_accelerator

    dynamic diff_disk_settings {
      for_each = var.os_disk_ephemeral ? [var.os_disk_ephemeral] : []
      content {
        option = "Local"
      }
    }
  }

  dynamic boot_diagnostics {
    for_each = var.enable_boot_diagnostics == false ? [] : [var.enable_boot_diagnostics]
    content {
      storage_account_uri = join(",", azurerm_storage_account.vm_sa.*.primary_blob_endpoint)
    }
  }

  dynamic identity {
    for_each = var.managed_identity_type == null || var.managed_identity_type == "" ? [] : [var.managed_identity_type]
    content {
      type         = identity.value
      identity_ids = var.managed_identity_ids
    }
  }

  # plan {
  #   name      = ""
  #   product   = ""
  #   publisher = ""
  # }

  dynamic secret {
    for_each = {}
    content {
      dynamic certificate {
        for_each = {}
        content {
          url = ""
        }
      }
      key_vault_id = ""
    }
  }

  source_image_reference {
    publisher = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_publisher, local.calculated_os_publisher) : null
    offer     = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_offer, local.calculated_os_offer) : null
    sku       = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_sku, local.calculated_os_sku) : null
    version   = var.vm_os_id == null || var.vm_os_id == "" ? var.vm_os_version : null
  }

}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  count               = var.is_windows_image || contains([lower(var.vm_os_simple), lower(var.vm_os_offer)], "windowsserver") ? 1 : 0
  name                = var.vm_hostname
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]
  allow_extension_operations   = var.allow_extension_operations
  availability_set_id          = var.availability_set_id
  computer_name                = var.computer_name
  custom_data                  = var.custom_data_file != null && var.custom_data_file != "" ? base64encode(file("${path.root}/${var.custom_data_file}")) : null
  dedicated_host_id            = var.dedicated_host_id
  enable_automatic_updates     = var.enable_automatic_updates
  license_type                 = var.license_type
  provision_vm_agent           = var.provision_vm_agent
  proximity_placement_group_id = var.proximity_placement_group_id
  source_image_id              = var.vm_os_id
  timezone                     = var.timezone
  virtual_machine_scale_set_id = var.scale_set_id
  zone                         = var.vm_availability_zone

  tags = merge(local.global_tags, var.vm_tags)

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd
  }

  dynamic additional_unattend_content {
    for_each = var.additional_unattended_content
    content {
      content = file("${path.root}/${each.value.content}")
      setting = each.value.setting
    }
  }

  os_disk {
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_sa_type
    disk_encryption_set_id    = null
    disk_size_gb              = var.os_disk_size_gb
    name                      = "${var.vm_hostname}-os_disk"
    write_accelerator_enabled = var.os_disk_enable_write_accelerator

    dynamic diff_disk_settings {
      for_each = var.os_disk_ephemeral ? [var.os_disk_ephemeral] : []
      content {
        option = "Local"
      }
    }
  }

  dynamic boot_diagnostics {
    for_each = var.enable_boot_diagnostics == false ? [] : [var.enable_boot_diagnostics]
    content {
      storage_account_uri = join(",", azurerm_storage_account.vm_sa.*.primary_blob_endpoint)
    }
  }

  dynamic identity {
    for_each = var.managed_identity_type == null || var.managed_identity_type == "" ? [] : [var.managed_identity_type]
    content {
      type         = identity.value
      identity_ids = var.managed_identity_ids
    }
  }

  # plan {
  #   name      = ""
  #   product   = ""
  #   publisher = ""
  # }

  dynamic secret {
    for_each = {}
    content {
      dynamic certificate {
        for_each = {}
        content {
          url = ""
        }
      }
      key_vault_id = ""
    }
  }

  source_image_reference {
    publisher = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_publisher, local.calculated_os_publisher) : null
    offer     = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_offer, local.calculated_os_offer) : null
    sku       = var.vm_os_id == null || var.vm_os_id == "" ? coalesce(var.vm_os_sku, local.calculated_os_sku) : null
    version   = var.vm_os_id == null || var.vm_os_id == "" ? var.vm_os_version : null
  }

  #   winrm_listener {
  #     protocol        = ""
  #     certificate_url = ""
  #   }
}

resource "azurerm_managed_disk" "vm_disk" {
  for_each = var.data_disks

  name                 = "${var.vm_hostname}_${each.key}"
  location             = coalesce(var.location, data.azurerm_resource_group.resource_group.location)
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  storage_account_type = each.value.storage_account_type
  # zones                = each.value.availability_zone

  tags = merge(local.global_tags, each.value.tags)
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_disk" {
  for_each = var.data_disks

  virtual_machine_id = ! contains([lower(var.vm_os_simple), lower(var.vm_os_offer)], "windowsserver") && ! var.is_windows_image ? azurerm_linux_virtual_machine.vm_linux[0].id : azurerm_windows_virtual_machine.vm_windows[0].id
  managed_disk_id    = azurerm_managed_disk.vm_disk[each.key].id
  lun                = each.value.lun
  caching            = each.value.caching
}

locals {
  # Merge user defined tags with tags added by automation.
  global_tags = merge(var.tags, var.auto_tags)

  standard_os = {
    "ubuntuserver"  = "Canonical,UbuntuServer,18.04-LTS"
    "windowsserver" = "MicrosoftWindowsServer,WindowsServer,2019-Datacenter"
    "rhel"          = "RedHat,RHEL,8.2"
    "opensuse-leap" = "SUSE,openSUSE-Leap,15.1"
    "centos"        = "OpenLogic,CentOS,7.6"
    "debian"        = "credativ,Debian,9"
    "coreos"        = "CoreOS,CoreOS,Stable"
    "sles"          = "SUSE,SLES,12-SP2"
  }

  calculated_os_publisher = "${element(split(",", lookup(local.standard_os, lower(var.vm_os_simple), "")), 0)}"

  calculated_os_offer = "${element(split(",", lookup(local.standard_os, lower(var.vm_os_simple), "")), 1)}"

  calculated_os_sku = "${element(split(",", lookup(local.standard_os, lower(var.vm_os_simple), "")), 2)}"

  calculated_remote_port = "${element(split(",", lookup(local.standard_os, lower(var.vm_os_simple), "")), 0) == "MicrosoftWindowsServer" ? 3389 : 22}"
}