
output "sql_username_secret" {
  value = azurerm_key_vault_secret.sql_username.value
}

output "sql_password_secret" {
  value = azurerm_key_vault_secret.sql_password.value
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}