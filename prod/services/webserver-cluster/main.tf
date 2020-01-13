provider "aws" {
  region = "us-west-2"
}

module "webserver_cluster" {
  source       = "../../../modules/services/webserver-cluster"
  cluster_name = "webservers-prod"
  bucket       = "slowteetoeterraformupandrunningstate"
  key          = "prod/data-stores/mysql/terraform.tfstate"
}
