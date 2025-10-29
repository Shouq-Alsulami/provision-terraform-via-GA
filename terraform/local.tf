
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
}