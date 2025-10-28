resource "azurerm_key_vault" "kvault" {
  resource_group_name           = var.rg_name
  location                      = var.rg_location
  name                          = var.name
  sku_name                      = "standard"
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment        = true
  public_network_access_enabled = true
  rbac_authorization_enabled    = false

  access_policy {
    object_id               = data.azurerm_client_config.current.object_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
    key_permissions         = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
    certificate_permissions = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
  }
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = var.subnet_ids
  }
}
