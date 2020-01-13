provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "slowteetoeterraformupandrunningstate"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "db_module" {
  source = "../../../modules/data-stores/mysql"
}
