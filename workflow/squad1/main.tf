data "terraform_remote_state" "ip" {
  backend = "atlas"
  config = {
    name = "${var.tfe_org}/${var.output_workspace}"
  }
}

resource "random_id" "random" {
  keepers = {
    uuid = "${uuid()}"
  }
  byte_length = 8
}
