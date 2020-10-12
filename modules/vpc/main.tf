# availability zones
data "aws_availability_zones" "main" {
}

# create a new VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name             = var.name
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# default route table
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name             = "default"
    TerraformManaged = "true"
  }
}

# public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = data.aws_availability_zones.main.names[count.index % length(data.aws_availability_zones.main.names)]
  map_public_ip_on_launch = true

  tags = {
    Name             = "${var.name}-${format("public-subnet-%03d", count.index + 1)}"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = data.aws_availability_zones.main.names[count.index % length(data.aws_availability_zones.main.names)]

  tags = {
    Name             = "${var.name}-${format("private-subnet-%03d", count.index + 1)}"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name             = var.name
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name             = var.name
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name             = var.name
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# route to internet
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# associate subnets to route tables
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# default security group
resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name             = "${var.name}-default"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# default network acl
# keep it do nothing
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name             = "${var.name}-default"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# allow public access
resource "aws_security_group" "public_web" {
  name        = "${var.name}-public_web"
  description = "Allow to access 80/443 from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name             = "${var.name}-public-web"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}

# security groups
resource "aws_security_group" "ssh" {
  name        = "${var.name}-ssh"
  description = "Security group for ssh"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr, "172.31.0.0/16"]
  }


  tags = {
    Name             = "${var.name}-ssh"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}


resource "aws_security_group" "db" {
  name        = "${var.name}-db"
  description = "Security group for db"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.cidr, "172.31.0.0/16"]
  }


  tags = {
    Name             = "${var.name}-db"
    Environment      = var.environment
    TerraformManaged = "true"
  }
}
