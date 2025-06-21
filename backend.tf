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




