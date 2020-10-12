output "yb94_vpc_id" {
  value = module.yb94_vpc.id
}

output "yb94_public_subnets" {
  value = module.yb94_vpc.public_subnets
}

output "yb94_private_subnets" {
  value = module.yb94_vpc.private_subnets
}

output "yb94_default_sg" {
  value = module.yb94_vpc.security_group_default
}

output "yb94_ssh_sg" {
  value = module.yb94_vpc.security_group_ssh
}

output "yb94_db_sg" {
  value = module.yb94_vpc.security_group_db
}

output "yb94_public_web_sg" {
  value = module.yb94_vpc.security_group_public_web
}
