output "vpc" {
  value = module.vpc
}

# output "sg" {
#   value = {
#     public_sg  = module.public_sg.security_group_id
#     private_sg = module.private_sg.security_group_id
#   }
# }