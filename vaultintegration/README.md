# Example of Vault/ TF Integration

Example code demonstrating how to retrieve secrets from Vault during a Terraform deployment.

Terraform has a [Vault provider](https://www.terraform.io/docs/providers/vault/index.html), which works the same as any other Terraform provider - you need to specify authentication credentials, and has several resources and data objects available to Vault.
For this example, we will use the "userpass" authentication method, however any other authentication method is supported, including token.

This user only needs the permissions required for the Terraform code. In the following example, since we are only retrieving two types of secrets, the following Vault ACL policy will suffice:

```
path "secret/foo" {
  capabilities = ["read"]
}

path "database/creds/read_only" {
  capabilities = ["read"]
}
```

## Demo Setup
### Vault
For this demo, you need to have an existing Vault server and a Database, and Vault configured as expected. You can use this as reference: https://github.com/stenio123/TFE_PoC2/

You can use the following commands to configure your Vault to work with this demo:

```
###
# Terraform user
#
# Enable userpass
vault auth enable userpass

# Create ACL policy for this user
echo '
path "secret/foo" {
  capabilities = ["read"]
}

path "database/creds/read_only" {
  capabilities = ["read"]
}'| vault policy write terraform_user -

# Create user
vault write auth/userpass/users/terraform_user password="Secret!" -policy=terraform_user

###
# Dynamic Secrets config
#
# Replace these variables accordingly:
export VAULT_ADDR=http://0.0.0.0:8200
export VAULT_TOKEN=root
export VAULT_DB_USER=
export VAULT_DB_USER_PASS=
# Connection string with port
export DB_CONNECTION_STRING=

# Mount secret engine
vault secrets enable database

# Configure MySQL connection
vault write database/config/mysql \
    plugin_name=mysql-legacy-database-plugin \
    connection_url="$VAULT_DB_USER:$VAULT_DB_USER_PASS@tcp($DB_CONNECTION_STRING)/" \
    allowed_roles=*

# Create role
vault write database/roles/read_only \
    db_name=mysql \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="2m" \
    max_ttl="24h"

# Validation
# vault read database/creds/readonly
```

### Terraform
## Variables:

### Environment Variables:
VAULT_ADDR: use this to inform your Vault server address. Example: http://myvault.local:8200

### Terraform Variables:
- login_username: A Vault username for TFE, with permissions to read the required secrets
- login_password: Password for that user
- static_secret_endpoint: Complete endpoint for a secret. Example secret/app1
- dynamic_secret_endpoint: Complete endpoint to a dynamic secret. Example database/creds/read_only
- dynamic_secret_role: Name of an existing role in the database secret mount. Example read_only
