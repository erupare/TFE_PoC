data "terraform_remote_state" "ip" {
  backend = "atlas"
  config = {
    name = "${var.tfe_org}/${var.output_workspace}"
  }
}

resource "random_id" "random" {
  keepers = {
    uuid = "${data.terraform_remote_state.ip.gcp_external_ip}"
  }
  byte_length = 8
}
