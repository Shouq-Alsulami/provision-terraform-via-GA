terraform {
  backend "azurerm" {
    resource_group_name  = "devops2-team3-storage-rg"
    storage_account_name = "devops2team3tfstate02"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
  }
}
