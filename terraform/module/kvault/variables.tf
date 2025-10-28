variable "rg_name" {

  type = string

}
variable "rg_location" {

  type = string

}
variable "name" {
  type = string 
}
variable "subnet_ids" {
  description = "List of subnet IDs that can access the Key Vault"
  type        = list(string)
}
