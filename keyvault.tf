// Azure key vault
resource "azurerm_key_vault" "my_key_vault" {
  name                = var.key-vault-name
  location            = var.location
  resource_group_name = var.resource-group-name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

// Allow service principal to read/write/delete secrets from Key Vault
resource "azurerm_key_vault_access_policy" "my_key_vault_access_policy_sp" {
  key_vault_id = azurerm_key_vault.my_key_vault.id
  tenant_id    = azurerm_key_vault.my_key_vault.tenant_id
  object_id    = data.azurerm_client_config.current.object_id #user executing terraform
  depends_on   = [azurerm_key_vault.my_key_vault]

  secret_permissions = [
    "get", "backup", "delete", "list", "recover", "restore", "set", "purge"
  ]
}
