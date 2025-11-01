resource "azurerm_key_vault" "key_vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  public_network_access_enabled = true

  access_policy {
    object_id    = data.azurerm_client_config.current.object_id
    tenant_id    = data.azurerm_client_config.current.tenant_id

    key_permissions         = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
    certificate_permissions = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
  }


  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    ip_rules                   = []
  }

}

data "azurerm_client_config" "current" {}
resource "random_password" "sql_admin" {
  length  = 16
  special = true
}
resource "random_id" "unique" {
  byte_length = 4
}
resource "azurerm_key_vault_secret" "sql_username" {
  name         = "sql-admin-username"
  value        = var.sql_username
  key_vault_id = azurerm_key_vault.key_vault.id
}
resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin.result
  key_vault_id = azurerm_key_vault.key_vault.id
}
resource "azurerm_key_vault_secret" "sql_server_name" {
  name         = "sql_server_name"
  value        = "${random_id.unique.hex}-sqlsrv"
  key_vault_id = azurerm_key_vault.key_vault.id
}