resource "azurerm_key_vault" "this" {
  name                        = "devops2-t3-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  public_network_access_enabled = true
  rbac_authorization_enabled   = false
  enabled_for_deployment       = true

  access_policy {
    object_id    = data.azurerm_client_config.current.object_id
    tenant_id    = data.azurerm_client_config.current.tenant_id

    key_permissions         = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
    certificate_permissions = ["Get", "List", "Update", "Delete", "Recover", "Backup", "Restore"]
  }

  network_acls {
    bypass                 = "AzureServices"
    default_action          = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
  }
}

data "azurerm_client_config" "current" {}
