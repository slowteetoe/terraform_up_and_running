terraform {
  source = "github.com/slowteetoe/terraform_up_and_running_modules//data-stores/mysql?ref=v0.0.7"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  db_name     = "example_stage"
  db_username = "admin"
  # set the DB password by setting the TF_VAR_db_password env var
}
