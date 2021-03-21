# Terraform Module `azure_resource_groups`

## Version: 1.0.0

### Terraform Syntax 0.12

This module has been created with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.

## Features

This Terraform module deploys [Resource Groups](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group "Azure Documentation") in Azure with the following characteristics:

* Create zero or more Resource Groups with same or different locations for each resource group.
* Support for applying tags to individual resource groups and/or applying tags on all resource groups.
* Support for applying additional tags to all resource groups as part of an automation pipeline.

## Usage

* Changing the name or location of a resource group will cause it to be destroyed then recreated. All resources in the group would be destroyed as well (and recreated if part of the config, but data would be lost).
* If a resource group needs to be moved/renamed without destroying existing resources then it needs to be moved manually in Azure and then imported into terraform state with the new name and/or location and update config to match.

```hcl
provider "azurerm" {
  features {}
}

module "resource_groups" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_resource_groups/v1.0.0"

  resource_groups = {
  "ExampleRG0" = {
    location = "Central US"
    tags = {Tag = "RGExample", Location = "Central US"}
  }
  "ExampleRG1" = {
    location = "West US"
    tags = {Tag = "RGExample", Location = "West US"}
  }
  "ExampleRG2" = {
    location = "South Central US"
    tags = {Tag = "RGExample", Location = "South Central US"}
  }
}
  tags = {
    Provisioner = "Terraform"
    ManagedBy   = "ManagedByTeam"
  }
}

output "resource_group_id" {
    value = module.resource_groups.resource_group_id
}
```

Recommended use for `auto_tags` variable is to generate a `tags.auto.tfvars` file as part of an automation pipeline to enforce default tags across all resources if needed. `auto_tags` merges with the universal `tags` and then merges with the resource specific `tags`.

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**resource_groups** `map(object)`

Description: Object mapping of resource groups. **Map Keys** are the resource group name.

Required objects:

* **location** `string`

  Description: [Azure location/region](https://azure.microsoft.com/en-us/global-infrastructure/locations/ "Azure Locations") of the resource group.

* **tags** `map(string)`

  Description: Mapping for azure resource metadata tags that will apply only to the corresponding resource group.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**tags** `map(string)`

Description: Mapping for azure resource metadata tags that will apply to all resources.

**auto_tags** `map(string)`

Description: Mapping for azure resource metadata tags that will apply to all resources (for use in automation pipeline).

## Outputs

**resource_group_id** `map(string)`

Description: Mapping of resource group IDs to name and location.

## Dependencies

Dependencies are external modules that this module references. A module is considered external if it isn't within the same repository.

**This module has no external module dependencies.**

### Module Dependencies

Providers are Terraform plugins that will be automatically installed during `terraform init` if available on the Terraform Registry.

* [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm "Terraform Registry")

## Resources and Data Sources

This is the list of resources/data sources that the module may create. The module can create zero or more of each of these resources/data sources depending on how many keys are defined. `for_each` and/or `count` values are determined at runtime. The goal of this section is to present the types of resources/data sources that may be created.

This list contains all of the resources/data sources this module plus any submodules may create. When using this module, it may create less resources if you use a submodule.

This module defines 0 data source(s):

This module defines 1 resource(s):

* `azurerm_resource_group.resource_group`
