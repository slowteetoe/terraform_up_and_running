provider "aws" {
  region = "us-west-2"
}

# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# note: internally TF will do something like 
# * aws_iam_user.example[0]: josecuervo
# * aws_iam_user.example[1]: johnnywalker
# * aws_iam_user.example[2]: jackdaniels
# If we were to pass in a different sized list, for example deleting johnnywalker
# we would see TF delete the third entry and rename the second from johnnywalker -> jackdaniels
# which is _probably_ not what we wanted

resource "aws_iam_user" "example" {
    for_each = toset(var.user_names)
    name = each.value
}