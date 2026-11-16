variable "aws_region" {
  description = "AWS region for the infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for AWS resources."
  type        = string
  default     = "three-tier-app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_username" {
  description = "Master username for the RDS database."
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "Master password for the RDS database. Supply via TF_VAR_db_password."
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type. Check AWS Academy restrictions before changing."
  type        = string
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "RDS instance class. Check AWS Academy restrictions before changing."
  type        = string
  default     = "db.t3.micro"
}
