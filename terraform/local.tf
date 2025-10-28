locals {
  prefix                  = "devops2-team3-project"
  location                = "malaysiawest"
  default_node_pool_name  = "team3"

  vnet_address_space      = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]

  sql_db = {
    username             = "auth-team3-project"
    collation            = "SQL_Latin1_General_CP1_CI_AS"
    password             = "Pr0j@ct_T3am#25"
    server_version       = "12.0"
    dbsize               = 1
    zone_redundant       = false
    sql_database_name    = "${local.prefix}-db"
    sku_name             = "Basic"
    storage_account_type = "Local"
  }

}