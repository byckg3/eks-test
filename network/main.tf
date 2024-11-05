data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0.0"
  name    = "${var.namespace}-vpc"
  cidr    = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  # enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# module "public_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 5.0"

#   name   = "public-sg"
#   vpc_id = module.vpc.vpc_id

#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   ingress_rules       = ["http-80-tcp", "https-443-tcp"]

#   number_of_computed_egress_with_source_security_group_id = 2
#   computed_egress_with_source_security_group_id = [
#     {
#       from_port                = 80
#       to_port                  = 80
#       protocol                 = "tcp"
#       source_security_group_id = module.private_sg.security_group_id
#     },
#     {
#       rule                     = "https-443-tcp"
#       source_security_group_id = module.private_sg.security_group_id
#     }
#   ]

#   tags = {
#     Project = "web-app"
#   }
# }

# module "private_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 5.0"

#   name   = "private-sg"
#   vpc_id = module.vpc.vpc_id

#   number_of_computed_ingress_with_source_security_group_id = 2
#   computed_ingress_with_source_security_group_id = [
#     {
#       rule                     = "http-80-tcp"
#       source_security_group_id = module.public_sg.security_group_id
#     },
#     {
#       rule                     = "https-443-tcp"
#       source_security_group_id = module.public_sg.security_group_id
#     }
#   ]

#   egress_rules = ["all-all"]

#   tags = {
#     Environment = "dev"
#     Project     = "module-test"
#   }
# }