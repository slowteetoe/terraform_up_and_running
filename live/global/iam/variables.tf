variable "user_names" {
    description = "Create an IAM user for each of these names"
    type = list(string)
    default = ["josecuervo","johnnywalker", "jackdaniels"]
}