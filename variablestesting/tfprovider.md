```
provider "tfe" {
  hostname = "${var.hostname}"
  token    = "${var.token}"
}

data "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "my-org-name"
}

resource "tfe_variable" "test" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  workspace_id = "${tfe_workspace.test.id}"
}

resource "tfe_variable" "test_sensitive" {
  key          = "my_key_name_sensitive"
  value        = "SecReT"
  category     = "terraform"
  sensitive    = "yes"
  workspace_id = "${tfe_workspace.test.id}"
}
```