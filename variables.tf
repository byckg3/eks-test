variable "aws_region" {
  default = "ap-northeast-1"
  type    = string
}

variable "namespace" {
  default = "tf"
  type    = string
}

variable "console_principal_arn" {
  type = string
}

# variable "ec2_key_name" {
#   type = string
# }

# variable "admin_ip" {
#   type = string
# }