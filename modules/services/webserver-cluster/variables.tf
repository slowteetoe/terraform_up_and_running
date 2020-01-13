variable "server_port" {
  description = "port for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "the name to use for all the cluster resources"
  type        = string
}

variable "db_host" {
  description = "the hostname of the database"
  type        = string
}

variable "db_port" {
  description = "the port of the database"
  type        = string
}

variable "instance_type" {
  description = "type of EC2 instance to run (e.g. t2.micro)"
  default     = "t2.micro"
  type        = string
}

variable "min_size" {
  description = "the minimum number of instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "the maximum number of instances in the ASG"
  type        = number
}
