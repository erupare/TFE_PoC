output "output_from_shared" {
  value = data.terraform_remote_state.ip.gcp_external_ip
}

output "output_from_random" {
  value = random_id.random.hex
}