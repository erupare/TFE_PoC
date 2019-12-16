# Set
# export VAULT_TOKEN
# export VAULT_ADDR
variable "login_username" {
  description = "A Vault username for TFE, with permissions to read the required secrets"
}
variable "login_password" {
  description = "Password for that user"
}

variable "static_secret_endpoint" {
  description = "Complete endpoint for a secret. Example secret/app1"
}
variable "dynamic_secret_endpoint" {
  description = "Complete endpoint to a dynamic secret. Example database/creds/read_only"
}
variable "dynamic_secret_role" {
  description = "Name of an existing role in the database secret mount"
}

variable "aws_az" {
  description = "Complete endpoint to a dynamic secret. Example database/creds/read_only"
}
variable "aws_instance_type" {
  description = "Name of an existing role in the database secret mount"
}
variable "aws_key" {
  description = "Name of an existing role in the database secret mount"
}

