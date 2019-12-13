

data "tfe_workspace" "test" {
  name         = var.tfe_workspace
  organization = var.tfe_org
}

resource "tfe_variable" "test" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  workspace_id = "${data.tfe_workspace.test.id}"
}

resource "tfe_variable" "test_sensitive" {
  key          = "my_key_name_sensitive"
  value        = "SecReT"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${data.tfe_workspace.test.id}"
}
