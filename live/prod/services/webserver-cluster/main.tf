provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "slowteetoeterraformupandrunningstate"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
  source       = "github.com/slowteetoe/terraform_up_and_running_modules//services/webserver-cluster?ref=v0.0.4"

  cluster_name = "webservers-prod"
  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 4
  db_host            = data.terraform_remote_state.db.outputs.db_host
  db_port            = data.terraform_remote_state.db.outputs.db_port
  enable_autoscaling = true

  custom_tags = {
    Owner      = "me"
    DeployedBy = "terraform"
  }
}

# read in the data from the provisioned mysql node
data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "slowteetoeterraformupandrunningstate"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  }
}