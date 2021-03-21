data "azurerm_virtual_machine" "existing" {
  name                = var.vmname
  resource_group_name = azurerm_managed_disk.example.resource_group_name
}

resource "azurerm_managed_disk" "example" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type =  var.storage_account_type #"Standard_LRS" or "Premium_LRS"
  create_option        = var.create_option
  source_uri           = var.source_uri           #URI to a valid VHD file to be used when create_option is Import
  source_resource_id   = var.source_resource_id   #ID of an existing managed disk to copy when create_option is Copy.
  disk_size_gb         = var.disk_size_gb
  tags     = var.tags
  storage_account_id = var.storage_account_id
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.example.id
  virtual_machine_id = data.azurerm_virtual_machine.existing.id
  lun                = var.lun_number
  caching            = var.cach_type              # Possible values include None, ReadOnly and ReadWrite
}