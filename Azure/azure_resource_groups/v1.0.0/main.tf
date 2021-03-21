### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates Azure Resource Groups.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
# ----------------------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "resource_group" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value.location
  tags     = merge(local.global_tags, each.value.tags)
}

locals {
  # Merge user defined tags with tags added by automation.
  global_tags = merge(var.tags, var.auto_tags)
}