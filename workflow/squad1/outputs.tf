output "output_from_shared" {
  value = "test"#data.terraform_remote_state.output.gcp_external_ip
}

output "output_from_random" {
  value = random_id.random.hex
}