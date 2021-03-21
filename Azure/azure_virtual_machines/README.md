# Terraform Module `azure_virtual_machines`

## Version: 1.0.0

### Terraform Syntax 0.13

This module has been created with 0.13 syntax, which means it is no longer compatible with any versions below 0.13.

## Features

This Terraform module deploys [Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/ "Azure Documentation") in Azure with the following characteristics:

## Usage

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.3"
    }
  }
  required_version = "~> 0.13.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "Central US"
}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}

module "virtual_machine" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_virtual_machines/v1.0.0"

resource_group_name = azurerm_resource_group.example.name
vnet_subnet_id = azurerm_virtual_network.example.subnet.subnet1.id
vm_hostname    = "testvm0"
vm_size        = "Standard_B1ls"
admin_username = "azureuser"
admin_password = "P@ssw0rd1234!"
vm_os_simple   = "ubuntuserver"
}
```

Recommended use for `auto_tags` variable is to generate a `tags.auto.tfvars` file as part of an automation pipeline to enforce default tags across all resources if needed. `auto_tags` merges with the universal `tags` and then merges with the resource specific `tags`.

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

## Outputs

## Dependencies

Dependencies are external modules that this module references. A module is considered external if it isn't within the same repository.

**This module has no external module dependencies.**

### Module Dependencies

Providers are Terraform plugins that will be automatically installed during `terraform init` if available on the Terraform Registry.

* [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm "Terraform Registry") - Minimum required version = 2.11.0
* [random](https://registry.terraform.io/providers/hashicorp/random "Terraform Registry") - Minimum required version = 2.3.0

## Resources and Data Sources

This is the list of resources/data sources that the module may create. The module can create zero or more of each of these resources/data sources depending on how many keys are defined. `for_each` and/or `count` values are determined at runtime. The goal of this section is to present the types of resources/data sources that may be created.

This list contains all of the resources/data sources this module plus any submodules may create. When using this module, it may create less resources if you use a submodule.

This module defines 1 data source(s):

* `azurerm_resource_group.resource_group`

This module defines 10 resource(s):

* `random_id.vm_sa`
* `azurerm_storage_account.vm_sa`
* `azurerm_public_ip.vm_public_ip`
* `azurerm_network_interface.vm_nic`
* `azurerm_network_security_group.vm_nsg`
* `azurerm_network_interface_security_group_association.vm_nsg`
* `azurerm_linux_virtual_machine.vm_linux`
* `azurerm_windows_virtual_machine.vm_windows`
* `azurerm_managed_disk.vm_disk`
* `azurerm_virtual_machine_data_disk_attachment.vm_disk`
