output "static_secret" {
  value = data.vault_generic_secret.my_static_secret
}

output "dynamic_secret" {
  value = data.vault_generic_secret.my_dynamic_secret
}

output "aws_external_ip" {
  value = "${aws_instance.ubuntu.public_ip}"
}