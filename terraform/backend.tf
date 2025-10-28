terraform {
  backend "azurerm" {
    resource_group_name  = "${var.prefix}-st-rg"
    storage_account_name = "${var.prefix}st"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
  }
}
