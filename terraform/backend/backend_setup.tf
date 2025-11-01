provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "tfstate_rg" {
  name     = "${var.prefix}-st-rg"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     =  "${var.prefix}st"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

output "tfstate_primary_access_key" {
  description = "Primary access key for the tfstate storage account"
  value       = azurerm_storage_account.tfstate.primary_access_key
  sensitive   = true
}

output "tfstate_blob_connection_string" {
  description = "Blob connection string for the tfstate storage account"
  value       = azurerm_storage_account.tfstate.primary_blob_connection_string
  sensitive   = true
}
