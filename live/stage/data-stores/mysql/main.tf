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
  source = "github.com/slowteetoe/terraform_up_and_running_modules//data-stores/mysql?ref=v0.0.1"
}
