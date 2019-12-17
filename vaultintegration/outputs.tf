output "static_secret" {
  value = data.vault_generic_secret.my_static_secret
}

output "dynamic_secret" {
  value = data.vault_generic_secret.my_dynamic_secret
}