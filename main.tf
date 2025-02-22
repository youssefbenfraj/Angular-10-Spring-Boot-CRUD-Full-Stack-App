terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

provider "azurerm" {
  features        {}
  subscription_id = "c7942088-7089-416c-97f1-d5c5d155a279"
  tenant_id       = "7917799a-9669-4e41-b87d-4c14fefd7c41"
  use_msi         = true
}

variable "managed_identity_id" {
  type    = string
  default = "subscriptions/c7942088-7089-416c-97f1-d5c5d155a279/resourceGroups/Terraform-Demo/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aaae7bd3-001d-4e0d-b95f-1821a780b047"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "Terraform-Demo"
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

   http_application_routing_enabled = true

identity {
      type        = "SystemAssigned"
    }
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "client_key" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key
    sensitive = true
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
    sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  sensitive = true
}
