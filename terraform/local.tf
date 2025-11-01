
variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "location" {
  type        = string
  description = "Azure region"
}
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

locals {
  vnet_address_space     = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]
  subnet_sql_prefixes     = ["10.1.2.0/24"]
  sql_db = {
    server_version       = "12.0"
    collation            = "SQL_Latin1_General_CP1_CI_AS"
    dbsize               = 1
    zone_redundant       = false
    sql_database_name    = "myappdb"
    sku_name             = "S0"
    storage_account_type = "GRS"
    username             = "sqladmin" 
  }
    # 🔹 AKS or other service defaults
  aks = {
    node_count = 2
    node_size  = "Standard_DS2_v2"
  }
}
