remote_state {
  backend = "s3"
  config = {
    bucket         = "slowteetoeterraformupandrunningstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
