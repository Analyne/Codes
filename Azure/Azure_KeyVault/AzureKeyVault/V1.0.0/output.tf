output "key-vault-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.keyvault.id
}

output "key-vault-url" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.keyvault.vault_uri
}