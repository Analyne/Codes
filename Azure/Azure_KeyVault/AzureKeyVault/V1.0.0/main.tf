data "azurerm_client_config" "current" {}

# Create the Azure Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.sku_name
  tags      = var.tags

  network_acls {
    default_action = "Deny"
    bypass         = var.bypass
    ip_rules = module.allowedIPs.Az_vault_allowed_IPs
    virtual_network_subnet_ids = var.subnetIds
  }
}

module allowedIPs{

  source  = "./../Azure_Network_ACL"
}

# Create an Azure Key Vault access policy
resource "azurerm_key_vault_access_policy" "policy" {
  for_each                = var.policies
  key_vault_id            = azurerm_key_vault.keyvault.id
  tenant_id               = lookup(each.value, "tenant_id")
  object_id               = lookup(each.value, "object_id")
  key_permissions         = lookup(each.value, "key_permissions")
  secret_permissions      = lookup(each.value, "secret_permissions")
  certificate_permissions = lookup(each.value, "certificate_permissions")
  storage_permissions     = lookup(each.value, "storage_permissions")
}
