//Azure DataF Factory
resource "azurerm_data_factory" "my_adf" {
  name                = var.adf-name
  location            = var.location
  resource_group_name = var.resource-group-name

  identity {
    type = "SystemAssigned"
  }

  dynamic "github_configuration" {
    for_each = var.github_configuration == null ? [] : [var.github_configuration]
    content {
      account_name    = github_configuration.value.github_account_name
      branch_name     = github_configuration.value.github_branch_name
      repository_name = github_configuration.value.github_repository_name
      root_folder     = github_configuration.value.github_root_folder
      git_url         = github_configuration.value.github_url
    }
  }

}

# Allow Data Factory to read secrets from Key Vault
resource "azurerm_key_vault_access_policy" "my_key_vault_access_policy_adf" {
  key_vault_id = azurerm_key_vault.my_key_vault.id
  tenant_id    = azurerm_key_vault.my_key_vault.tenant_id
  object_id    = azurerm_data_factory.my_adf.identity[0].principal_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}
