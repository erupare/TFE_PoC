

output "output_from_random" {
  value = random_id.random.hex
}

output "keepers" {
  value = random_id.random.keepers
}