provider "azurerm" {
	version 		= "~>2.0"
	suscription_id	= "${var.azure_suscription_id}"
	tenant_id 		= "${var.suscription_id}"
	feature {}

}


resource "azurerm_resource_group" "prueba_terraform"{
  name = var.resource_group_name
  location = var.location
  
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name 					= var.cluster_name
  location 				= azurerm_resource_group.location
  resource_group_name 	= azurerm_resource_group.name

  linux_profile {
      admin_username = var.linux_user
	
	  ssh_key {
	      key_data = file(var.ssh_public_key)
	  }
  
  }
  
  default_node_pool {
      name			= "agentpool"
	  node_count	= var.agent_count
	  vm_size 		= "Standard_DS1_v2"
  }


  tags = {
      enviroment = "Develop"
  }

}


resource "azurerm_virtual_network" "prueba_terraform" {
  name                  = "aks-vnet"
  resource_group_name   = azurerm_resource_group.name
  address_space         = var.net_addres
  location              = var.location

}

resource "azurerm_subnet" "prueba_terraform" {
  name                  = "aks-subnet"
  resource_group_name   = azurerm_resource_group.name
  addres_prefix         = var.subnet-addres  

}

resource "azurerm_public_ip" "prueba_terraform" {
  name                         = "aks-public-ip"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.name
  public_ip_address_allocation = "static"
  
}






