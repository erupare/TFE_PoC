output "output_from_shared" {
  value = terraform_remote_state.output.gcp_external_ip
}