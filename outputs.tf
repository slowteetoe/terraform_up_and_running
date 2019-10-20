output "public_ip" {
    value = aws_instance.example.public_ip
    description = "public IP address for the web server"
}