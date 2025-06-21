provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }


  subscription_id = var.subscription_id
}
# provider "azurerm" {                        
#   features {}
  
#   subscription_id = var.subscription_id
 
# }
provider "kubernetes" {
  config_path = "~/.kube/config"
}
//az aks get-credentials --resource-group aks-resources-kkt-9955 --name example-aks1


resource "azurerm_resource_group" "example" {
  name     = "aks-resources-kkt-9955"
  location = "West Europe"
  
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}
//
# resource "azurerm_log_analytics_workspace" "log_workspace" {
#   name                = "log-workspace"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# resource "azurerm_monitor_diagnostic_setting" "monitor" {
#   name                       = "audit"
#   target_resource_id         = azurerm_kubernetes_cluster.example.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id

#   enabled_log {
#     category = "kube-apiserver"
#   }

#   enabled_log {
#     category = "kube-controller-manager"
#   }

#   enabled_log {
#     category = "cluster-autoscaler"
#   }

#   enabled_log {
#     category = "kube-scheduler"
#   }

#   enabled_log {
#     category = "kube-audit"
#   }

#   metric {
#     category = "AllMetrics"
#   }

# }
