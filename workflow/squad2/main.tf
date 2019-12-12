data "terraform_remote_state" "ip" {
  backend = "atlas"
  config = {
    name = "${var.tfe_org}/${var.output_workspace}"
  }
}

resource "random_id" "random" {
  byte_length = 8
}
