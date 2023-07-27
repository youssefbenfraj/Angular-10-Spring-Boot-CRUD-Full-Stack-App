provider "azurerm" {
  features {}
 subscription_id = "c7942088-7089-416c-97f1-d5c5d155a279"
  use_msi        = true
}

variable "managed_identity_id" {
  type = string
  default = "aaae7bd3-001d-4e0d-b95f-1821a780b047"
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
    identity_ids = [var.managed_identity_id]
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate
}
