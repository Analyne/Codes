provider "azurerm" {
 
  features {}
}

# Create ResourceGroup
resource "azurerm_resource_group" "RG" {
  name = var.ResourceGroup
  location = var.location
  tags     = var.tags
}