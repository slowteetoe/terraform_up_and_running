provider "aws" { region = "us-west-2" }

resource "aws_instance" "example" {
  ami = "ami-06d51e91cea0dac8d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "hola mundo" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  
  tags = {
    Name = "tf-example"
  }
}

resource "aws_security_group" "instance" {
  name = "tf-example-instance"

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
