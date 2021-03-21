#Create Data Factory 
resource "azurerm_data_factory" "DF" {
  name = var.df_name
  location = var.location
  resource_group_name = var.rg_name
  tags =  var.tags
  identity {
  type = "SystemAssigned"
  }
}
