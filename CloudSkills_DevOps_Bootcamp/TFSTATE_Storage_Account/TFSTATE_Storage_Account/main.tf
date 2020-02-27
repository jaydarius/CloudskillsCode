provider azurerm {
    version = "2.0.0"
}

resource "azurerm_storage_account" "CloudSkillsStorageAccount" {
    name = "TFSTATESTORAGE"
    resource_group_name = var.resourceGroup
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_container" "CloudSkillsContainer" {
    name = "TFSTATE"
    resource_group_name = var.resourceGroup
    storage_account_name = "${azurerm_storage_account.CloudSkillsStorageAccount.name}"
    container_access_type = "blob"
}