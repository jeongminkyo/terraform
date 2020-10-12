# The ID of the VPC
output "id" {
  value = aws_vpc.main.id
}

# The CIDR block of the VPC
output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

# A list of public subet IDs
output "public_subnets" {
  value = aws_subnet.public.*.id
}

# A list of private subet IDs
output "private_subnets" {
  value = aws_subnet.private.*.id
}

# The list of availability zones of the VPC.
output "availability_zones" {
  value = data.aws_availability_zones.main.names
}

# security groups
output "security_group_default" {
  value = aws_default_security_group.main.id
}


output "security_group_public_web" {
  value = aws_security_group.public_web.id
}


output "security_group_ssh" {
  value = aws_security_group.ssh.id
}

output "security_group_db" {
  value = aws_security_group.db.id 
}

