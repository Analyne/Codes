output "resource_group_id" {
  value = {
    for rg in azurerm_resource_group.resource_group :
    rg.id => "${rg.name}_${rg.location}"
  }
}