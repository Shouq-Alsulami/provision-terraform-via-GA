output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.kvault.id
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.kvault.name
}

output "key_vault_uri" {
  description = "The URI endpoint of the Key Vault"
  value       = azurerm_key_vault.kvault.vault_uri
}