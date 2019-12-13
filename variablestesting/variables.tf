# Set
# export TFE_TOKEN
# export TFE_ADDR

variable "tfe_org" {
  description = "TFE workspace"
  default = "TFE_PoV"
}
variable "tfe_workspace" {
  description = "TFE workspace"
  default = "Squad1-dev"
}