output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster API server"
  value       = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  description = "The database endpoint (hostname and port)"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_database_name" {
  description = "The database name"
  value       = aws_db_instance.postgres.db_name
}

output "kubeconfig_configure_command" {
  description = "Run this command to configure kubectl credentials locally"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}
