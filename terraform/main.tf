module "rg" {
  source   = "./module/resource_group"
  name     = "${local.prefix}-rg"
  location = local.location
}

module "vnet" {
  source              = "./module/virtual_network"
  name                = "${local.prefix}-vnet"
  location            = module.rg.resource_group.location
  resource_group_name = module.rg.resource_group.name
  address_space       = local.vnet_address_space
}

module "subnet" {
  source              = "./module/subnets"
  name                = "aks-subnet"
  vnet_name           = module.vnet.virtual_network.name
  resource_group_name = module.rg.resource_group.name
  address_prefixes    = local.subnet_address_prefixes
}
module "subnet_sql" {
  source              = "./module/subnets"
  name                = "sql-private-subnet"
  vnet_name           = module.vnet.virtual_network.name
  resource_group_name = module.rg.resource_group.name
  address_prefixes    = ["10.1.2.0/24"]  
}


module "aks" {
  source                   = "./module/aks"
  name                     = "${local.prefix}-aks"
  resource_group_name      = module.rg.resource_group.name
  location                 = module.rg.resource_group.location 
  dns_prefix               = "${local.prefix}-dns"
  vnet_subnet_id           = module.subnet.subnet.id
  identity_type            = "SystemAssigned"
  node_resource_group_name = "${local.prefix}-aks"
  default_node_pool_name   = local.default_node_pool_name
}
module "sql" {
  source               = "./module/sql_db"

  # Base settings
  collation            = local.sql_db.collation
  resource_group_name  = module.rg.resource_group.name
  location             = module.rg.resource_group.location
  username             = local.sql_db.username
  password             = local.sql_db.password
  server_name          = "${local.prefix}-sqlserver"
  server_version       = local.sql_db.server_version
  dbsize               = local.sql_db.dbsize
  zone_redundant       = local.sql_db.zone_redundant
  sql_database_name    = local.sql_db.sql_database_name
  sku_name             = local.sql_db.sku_name
  storage_account_type = local.sql_db.storage_account_type

  # 🔒 Private Endpoint configuration
  vnet_id  = module.vnet.virtual_network.id
  subnet_id = module.subnet_sql.subnet.id

}



module "container_registry" {
  source              = "./module/container_registry"
  acr_name            = "devops2team3acr02"
  resource_group_name = module.rg.resource_group.name
  location            = module.rg.resource_group.location
}

module "kvault" {
  source = "./module/kvault"
  rg_name = module.rg.resource_group.name
  rg_location = module.rg.resource_group.location
  name = "${local.prefix}-kvault"
  subnet_ids = module.subnet_sql.subnet.id
} 