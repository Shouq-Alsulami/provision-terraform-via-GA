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
module "subnet" {
  source              = "./module/subnets"
  name                = "${var.prefix}-aks-subnet"
  vnet_name           = module.vnet.virtual_network.name
  resource_group_name = module.rg.resource_group.name
  address_prefixes    = local.subnet_address_prefixes
}
module "subnet_sql" {
  source              = "./module/subnets"
  name                = "${var.prefix}-sql-subnet"
  vnet_name           = module.vnet.virtual_network.name
  resource_group_name = module.rg.resource_group.name
  address_prefixes    = ["10.1.2.0/24"]  
}
module "aks" {
  source                   = "./module/aks"
  name                     = "${var.prefix}-aks"
  resource_group_name      = module.rg.resource_group.name
  location                 = module.rg.resource_group.location 
  dns_prefix               = "${var.prefix}-dns"
  vnet_subnet_id           = module.subnet.subnet.id
  identity_type            = "SystemAssigned"
  node_resource_group_name = "${var.prefix}-aks"
  default_node_pool_name   = "${var.prefix}-nodepool"
}

# module "sql" {
#   source               = "./module/sql_db"

#   # Base settings
#   collation            = local.sql_db.collation
#   resource_group_name  = module.rg.resource_group.name
#   location             = module.rg.resource_group.location
#   username             = local.sql_db.username
#   password             = local.sql_db.password
#   server_name          = "${var.prefix}-sqlserver"
#   server_version       = local.sql_db.server_version
#   dbsize               = local.sql_db.dbsize
#   zone_redundant       = local.sql_db.zone_redundant
#   sql_database_name    = local.sql_db.sql_database_name
#   sku_name             = local.sql_db.sku_name
#   storage_account_type = local.sql_db.storage_account_type

#   #  Private Endpoint configuration
#   vnet_id  = module.vnet.virtual_network.id
#   subnet_id = module.subnet_sql.subnet.id

# }
module "key_vault" {
  source              = "./module/key_vault"
  prefix              = "${var.prefix}-kv"
  location            = module.rg.resource_group.location
  resource_group_name = module.rg.resource_group.name
  subnet_id           = module.subnet.subnet.id 
}