# CSM Terraform Registry

[<img src="https://www.terraform.io/assets/images/logo-hashicorp-3f10732f.svg" width="300px">](https://www.terraform.io/ "HashiCorp Terraform")

This registry contains private Terraform modules managed and maintained by the CSM team. Modules are typically organized by the provider for which they provision resources from (ie. Azure folder contains modules for provisioning azure resources), although it is possible for modules to provision resources from multiple providers. See [Creating Modules](https://www.terraform.io/docs/modules/index.html "Terraform Documentation") for Terraform documentation on creating new modules.

## Utilizing a Module from the Registry

Each module will contain documentation with usage examples. If new to Terraform, please review Terraform documentation on [Calling Modules](https://www.terraform.io/docs/configuration/modules.html#calling-a-child-module "Terraform Documentation").

Example calling the azure_resource_groups module:

```hcl
# Calling a module:
module "resource_groups" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_resource_groups/v1.0.0"
}

# Module version attribute is not supported by private registry.
# To change module version, simply reference a different version folder:
module "resource_groups" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_resource_groups/v1.1.0"
}
```

Review respective module documentation for changes and compatibility before upgrading to a new version.

## Versioning and Changelog Best Practices

Modules are currently versioned by separating code into folders with versioned names (ie. Azure/azure_resource_groups/v1.0.0). Each module folder contains a changelog and a readme with examples for the latest version. The readme for each version is also contained in its respective version folder. Follow the best practices guidelines provided by HashiCorp for [Versioning and Changelog](https://www.terraform.io/docs/extend/best-practices/versioning.html "Terraform Documentation").
