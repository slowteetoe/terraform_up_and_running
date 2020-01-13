provider "aws" {
  region = "us-west-2"
}

module "db_module" {
  source                 = "../../../modules/data-stores/mysql"
  db_remote_state_bucket = "slowteetoeterraformupandrunningstate"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
}
