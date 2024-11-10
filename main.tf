module "network" {
  source    = "./network"
  namespace = var.namespace
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.namespace}-eks"
  cluster_version = "1.31"

  vpc_id     = module.network.vpc.vpc_id
  subnet_ids = module.network.vpc.private_subnets

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro"] # max 4 pods
  }

  eks_managed_node_groups = {
    group1 = {
      name = "node-group-1"

      instance_types = ["t3.small"] # max 11 pods

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  access_entries = {
    # One access entry with a policy associated
    eks_console = {
      principal_arn     = var.console_principal_arn
      kubernetes_groups = []

      policy_associations = {
        admin_policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
            namespaces = []
          }
        }
      }
    }
  }
}