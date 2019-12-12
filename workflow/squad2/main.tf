data "terraform_remote_state" "ip" {
  backend = "atlas"
  config = {
    name = "${var.tfe_org}/${var.output_workspace}"
  }
}

resource "random_id" "random" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = "${var.ami_id}"
  }
  byte_length = 8
}
