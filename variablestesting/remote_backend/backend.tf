terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "TFE_PoV"

    workspaces {
      name = "Squad1-3"
    }
  }
}