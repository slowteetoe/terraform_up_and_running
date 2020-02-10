terraform {
  source = "github.com/slowteetoe/terraform_up_and_running_modules//services/hello-world-app?ref=v0.0.7"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../data-stores/mysql"]
}

inputs = {
  environment = "stage"

  server_text = "hello from staging"

  min_size = 2
  max_size = 3

  enable_autoscaling = false

  db_remote_state_bucket = "slowteetoeterraformupandrunningstate"
  db_remote_state_key    = "data-stores/mysql/terraform.tfstate"

  ami           = "ami-06d51e91cea0dac8d"
  instance_type = "t2.micro"
}
