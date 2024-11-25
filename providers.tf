provider "aws" {
  region  = var.aws_region
  profile = "tf-user"
  # shared_credentials_files = ["~/.aws/credentials"][tf-user]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

locals {
  cluster_endpoint = module.eks.cluster_endpoint
  ca_certificate   = base64decode(module.eks.cluster_certificate_authority_data)
  auth_token       = data.aws_eks_cluster_auth.this.token
}

provider "kubernetes" {
  host                   = local.cluster_endpoint
  cluster_ca_certificate = local.ca_certificate
  token                  = local.auth_token
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   args        = ["eks", "get-token", "--cluster-name", data.eks_cluster.this.name]
  # }
}
provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.ca_certificate
    token                  = local.auth_token
  }
}