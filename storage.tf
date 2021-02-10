// Azure Data Lake Storage
resource "azurerm_storage_account" "my_storage" {
  name                      = var.storage-name
  resource_group_name       = var.resource-group-name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  account_kind              = "StorageV2"
  is_hns_enabled            = "true"
  enable_https_traffic_only = "true"
}

// Create storage container
resource "azurerm_storage_container" "my_storage_container" {
  name                  = "datalake"
  storage_account_name  = azurerm_storage_account.my_storage.name
  container_access_type = "private"
}

// Create key vault secret for primary access key
resource "azurerm_key_vault_secret" "my_key_vault_primary_access_key" {
  name         = format("%s%s", azurerm_storage_account.my_storage.name, "-primary-access-key")
  value        = azurerm_storage_account.my_storage.primary_access_key
  key_vault_id = azurerm_key_vault.my_key_vault.id
  depends_on   = [azurerm_key_vault_access_policy.my_key_vault_access_policy_sp]
}
