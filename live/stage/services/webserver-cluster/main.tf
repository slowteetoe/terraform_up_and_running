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
  source       = "github.com/slowteetoe/terraform_up_and_running_modules//services/webserver-cluster?ref=v0.0.1"
  cluster_name = "webservers-stage"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 4
  db_host       = data.terraform_remote_state.db.outputs.db_host
  db_port       = data.terraform_remote_state.db.outputs.db_port
}

# pointless rule, just to show that we can now attach security rules
resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id
  from_port         = 12345
  to_port           = 12345
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
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
