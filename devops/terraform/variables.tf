variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1" # Mumbai Region (matches user timezone +05:30)
}

variable "environment" {
  description = "Environment identifier"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "gocart-prod-eks"
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "gocart"
}

variable "db_username" {
  description = "Username for the RDS PostgreSQL database"
  type        = string
  default     = "gocartadmin"
}

variable "db_password" {
  description = "Password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}
