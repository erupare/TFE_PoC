data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "example" {
  name                = var.existing_key_vault_name
  resource_group_name = var.rg_name
}

# Example retrieving existing secret
data "azurerm_key_vault_secret" "example" {
  name         = var.existing_secret_name
  key_vault_id = data.azurerm_key_vault.example.id
}


# Example creating new keyvault and new secret
resource "azurerm_resource_group" "test" {
  name     = "stenio-poc"
  location = "West US"
}

resource "random_id" "server" {
  keepers = {
    ami_id = 1
  }

  byte_length = 8
}

resource "azurerm_key_vault" "test" {
  name                = format("%s%s", "kv", random_id.server.hex)
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.service_principal_object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list",
    ]
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_key_vault_secret" "test" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.test.id

  tags = {
    environment = "Production"
  }
}