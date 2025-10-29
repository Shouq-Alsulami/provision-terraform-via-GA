# ──────────── Provider ────────────
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id =  var.subscription_id
}

# ──────────── Variables ────────────
variable "subscription_id" {
  type        = string
  default     = "80646857-9142-494b-90c5-32fea6acbc41"
}
variable "resource_group" {
  description = "Name of the Resource Group to store Terraform state"
  type        = string
}

variable "sa_name" {
  description = "Name of the Storage Account for Terraform state"
  type        = string
}

variable "container" {
  description = "Name of the blob container to store Terraform state files"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

# ──────────── Resource Group ────────────
resource "azurerm_resource_group" "tfstate_rg" {
  name     = var.resource_group
  location = var.location
}

# ──────────── Storage Account ────────────
resource "azurerm_storage_account" "tfstate" {
  name                     = var.sa_name
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# ──────────── Blob Container ────────────
resource "azurerm_storage_container" "tfstate" {
  name                  = var.container
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

# ──────────── Outputs ────────────
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
