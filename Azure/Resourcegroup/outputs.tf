#ResourceGrup Name
output "ResourceGroup_name" {
  value = azurerm_resource_group.RG.name
}
#ResourceGroup Location
output "ResourceGroup_Location" {
  value = azurerm_resource_group.RG.location
}
