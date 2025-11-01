variable "name" {
    description = "The name of the Key Vault"
    type        = string
}
variable "location" {
    description = "The location of the Key Vault"
    type        = string
}
variable "resource_group_name" {
    description = "The resource group name where the Key Vault will be created"
    type        = string
}
variable "subnet_id" {
    description = "The subnet ID where the Key Vault is located"
    type        = string
}
variable "sql_username" {
    description = "The SQL admin username to store in Key Vault"
    type        = string
}