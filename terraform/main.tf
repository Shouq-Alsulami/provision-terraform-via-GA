module "rg" {
  source   = "./module/resource_group"
  name     = "${var.prefix}-rg"
  location = var.location
}

module "vnet" {
  source              = "./module/virtual_network"
  name                = "${var.prefix}-vnet"
  location            = module.rg.resource_group.location
  resource_group_name = module.rg.resource_group.name
  address_space       = local.vnet_address_space
}

module "container_registry" {
  source              = "./module/container_registry"
  acr_name            = "${var.prefix}-acr"
  resource_group_name = module.rg.resource_group.name
  location            = module.rg.resource_group.location
}