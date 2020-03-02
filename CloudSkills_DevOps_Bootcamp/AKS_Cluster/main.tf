terraform {
  backend "azurerm" {
    resource_group_name = var.resourceGroup
    storage_account_name = var.storageAccountName
    container_name = var.containerName
    key = "terraform.state"
  }
}

provider azurerm {
  version = "2.0.0"
  features {}
}

module "env" {
  source = "./TFSTATE_Storage_Account"
}

resource "azurerm_kubernetes_cluster" "CloudSkillsAKS" {
  name                = "cloudskillsaks"
  location            = "${module.env.location}"
  resource_group_name = "${module.env.resourceGroup}"
  dns_prefix          = concat([azurerm_kubernetes_cluster.CloudSkillsAKS.name, "-prefix"])

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "Standard_D2_v2"
  }

  
}