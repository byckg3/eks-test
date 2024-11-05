terraform {
  cloud {
    organization = "tf-team"
    workspaces {
      name = "eks-dev-ap-northeast"
    }
  }
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}