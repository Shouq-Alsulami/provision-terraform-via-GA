
variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "location" {
  type        = string
  description = "Azure region"
}

locals {
  vnet_address_space      = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]
}