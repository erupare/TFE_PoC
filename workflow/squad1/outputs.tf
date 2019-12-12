

output "output_from_random" {
  value = random_id.random.hex
}

output "exemplo" {
  value = module2.exemplo
}

# output "keepers" {
#  value = random_id.random.keepers
# }