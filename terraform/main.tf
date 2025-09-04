terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.33"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate23632"
    container_name       = "tfstate"
    key                  = "terraform.k8stfstate"
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "Poland Central"
}