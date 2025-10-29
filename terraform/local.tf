
variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}
variable "subscription_id" {
  type = string
  default = "80646857-9142-494b-90c5-32fea6acbc41"
}

locals {
  vnet_address_space      = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]
    sql_db = {
    username             = "auth-team3-project"
    collation            = "SQL_Latin1_General_CP1_CI_AS"
    password             = "Pr0j@ct_T3am#25"
    server_version       = "12.0"
    dbsize               = 1
    zone_redundant       = false
    sql_database_name    = "${var.prefix}-db"
    sku_name             = "Basic"
    storage_account_type = "Local"
  }
}
