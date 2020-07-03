provider "azurerm" {
  version ="=2.0.0"  
  features {}
  
}


resource "azurerm_resource_group" {
  name = var.resource_group_name
  location = var.location
  
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name 					= var.cluster_name
  location 				= var.location
  resource_group_name 	= 

  linux_profile {
      admin_username = var.linux_user
	
	  ssh_key {
	      key_data = file(var.ssh_public_key)
	  }
  
  }


}