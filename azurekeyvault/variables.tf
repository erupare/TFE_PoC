
variable "rg_name" {
  description = "Name of existing Resource Group where KeyVault is"
  default = "stenio-rg"
}

variable "existing_key_vault_name" {
  description = "Name of existing keyVault you want to retrieve secret from"
  default = "stenio-keyvault"
}

variable "existing_secret_name" {
  description = "Name of existing secret you want to retrieve"
  default = "stenio-secret"
}
