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
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}
