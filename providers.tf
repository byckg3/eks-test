provider "aws" {
  region  = var.aws_region
  profile = "tf-user"
  # shared_credentials_files = ["~/.aws/credentials"][tf-user]
}