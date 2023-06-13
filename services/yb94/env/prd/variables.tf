variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "env" {
  description = "env name"
  type        = string
  default     = "prd"
}

variable "name" {
  description = "The name for the VPC"
  type        = string
  default     = "YB94"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnets" {
  description = "CIDR list of public subnets"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR list of private subnets"
  type        = list(string)
  default     = ["10.20.101.0/24", "10.20.102.0/24"]
}

variable "rds_subnets" {
  description = "CIDR list of rds subnets"
  type        = list(string)
  default     = ["10.20.103.0/24", "10.20.104.0/24"]
}

variable "rds_storage" {
  description = "rds storage"
  type        = number
  default     = 20
}

variable "db_engine" {
  description = "rds database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "rds database engine version"
  type        = string
  default     = "5.7.38"
}

variable "db_instance_class" {
  description = "rds instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "db_user_name" {
  description = "database user name"
  type        = string
  default     = "YB94"
}

variable "db_password" {
  description = "database user password"
  type        = string
  sensitive = true
}

variable "database_name" {
  description = "first database name"
  type        = string
  default     = "YB94_production"
}

variable "database_port" {
  description = "allow port number"
  type        = number
  default     = 3306
}

variable "domain_name" {
  description	= "jailgas.com domain"
  type			= string
  default		= "yb94.name"
}

