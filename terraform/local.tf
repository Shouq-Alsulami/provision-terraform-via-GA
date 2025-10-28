
variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "location" {
  type        = string
  description = "Azure region"
}
variable "default_node_pool_name" {
  type        = string
  description = "Default node pool name for AKS"
}


locals {
  # prefix                  = "devops2-team3-project"
  # location                = "malaysiawest"
  # default_node_pool_name  = "team3"
  vnet_address_space      = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]
}