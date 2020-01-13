provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "slowteetoeterraformupandrunningstate"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
  source       = "../../../modules/services/webserver-cluster"
  cluster_name = "webservers-stage"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 4
  db_host       = data.terraform_remote_state.db.outputs.db_host
  db_port       = data.terraform_remote_state.db.outputs.db_port
}

# read in the data from the provisioned mysql node
data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "slowteetoeterraformupandrunningstate"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  }
}
