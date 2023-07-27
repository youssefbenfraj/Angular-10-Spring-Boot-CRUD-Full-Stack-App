provider "azurerm" {
  features {}
 subscription_id = "c7942088-7089-416c-97f1-d5c5d155a279"
  use_msi        = true
}

variable "managed_identity_id" {
  type = string
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "Jenkins-Terraform-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "Terraform-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "Terraform-cluster-dns"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }
}
