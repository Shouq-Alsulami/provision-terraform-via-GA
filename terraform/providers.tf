# Decode kubeconfig
locals {
  kubeconfig = yamldecode(module.aks.kube_config)
}

#  Azurerm provider
provider "azurerm" {
  features {}
  subscription_id = "b082ca8a-c291-4afc-9bda-41db24bec971"
}

# Kubernetes provider
provider "kubernetes" {
  host                   = local.kubeconfig["clusters"][0]["cluster"]["server"]
  cluster_ca_certificate = base64decode(local.kubeconfig["clusters"][0]["cluster"]["certificate-authority-data"])
  client_certificate     = base64decode(local.kubeconfig["users"][0]["user"]["client-certificate-data"])
  client_key             = base64decode(local.kubeconfig["users"][0]["user"]["client-key-data"])
}

# Helm provider (without k8s block) 
provider "helm" {
  kubernetes = {
    host                   = local.kubeconfig["clusters"][0]["cluster"]["server"]
    cluster_ca_certificate = base64decode(local.kubeconfig["clusters"][0]["cluster"]["certificate-authority-data"])
    client_certificate     = base64decode(local.kubeconfig["users"][0]["user"]["client-certificate-data"])
    client_key             = base64decode(local.kubeconfig["users"][0]["user"]["client-key-data"])
  }
}
