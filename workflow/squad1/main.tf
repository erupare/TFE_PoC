data "terraform_remote_state" "ip" {
  backend = "atlas"
  config = {
    name = "${var.tfe_org}/${var.output_workspace}"
  }
}
module "module2" {
  source  = "app.terraform.io/TFE_PoV/module2/demo"
  version = "1.0.2"

  test_var = "teste"
}

resource "random_id" "random" {
  byte_length = 16
}
