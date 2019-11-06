###
# Secret in Azure KeyVault
###
# Reference to existing Azure keyvault - check line 42 below for example
# data "azurerm_key_vault_secret" "test" {
#   name         = "secret-sauce"
#   key_vault_id = "${data.azurerm_key_vault.existing.id}"
# }


###
# Secret in Hashicorp Vault
###
# Specify which Vault and access token
# provider "vault" {
    # It is strongly recommended to configure this provider through the
    # environment variables described above, so that each user can have
    # separate credentials set in the environment.
    #
    # This will default to using $VAULT_ADDR
    # But can be set explicitly
    # address = "https://vault.example.net:8200"
    # export VAULT_ADDR
    # export VAULT_URL
# }
# Retrieves secret - check line 42 below for example of usage
# data "vault_generic_secret" "client_secret" {
#   path = "secret/client_secret"
# }


resource "azurerm_resource_group" "test" {
  name     = "acctestRG1"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "acctestaks1"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  dns_prefix          = "acctestagent1"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  agent_pool_profile {
    name            = "pool2"
    count           = 1
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
    # client_secret = "${data.azurerm_key_vault_secret.test.value}"
    # client_secret = "${data.vault_generic_secret.client_secret.data["secret_value"]}"

  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.test.kube_config_raw}"
}