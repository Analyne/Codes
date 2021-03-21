#DataFactoryName
output "DataFactory_name" {
  value = azurerm_data_factory.DF.name
}

output "DataFactory_id"{
  value = azurerm_data_factory.DF.identity[0].principal_id

}