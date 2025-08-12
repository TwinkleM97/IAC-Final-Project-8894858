variable "aws_region" { type = string }
variable "aws_profile" { type = string }
variable "student_alias" { type = string }
variable "student_id" { type = string }
variable "enable_bucket_versioning" { type = bool }
variable "key_name" { type = string }
variable "allowed_ssh_cidr" { type = string }
variable "instance_type" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "db_name" { type = string }
variable "db_username" { type = string }

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_allocated_storage" { type = number }
