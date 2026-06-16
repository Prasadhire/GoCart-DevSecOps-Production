module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Groups
  eks_managed_node_groups = {
    gocart_nodes = {
      name           = "gocart-node-group"
      instance_types = ["c7i-flex.large"]

      min_size     = 2
      max_size     = 5
      desired_size = 2

      # Use SSD based GP3 volumes
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 30
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            encrypted             = true
            delete_on_termination = true
          }
        }
      }
    }
  }

  # Enable IAM Roles for Service Accounts (IRSA) via OIDC
  enable_irsa = true

  #Grant cluster admin permissions to the IAM identity creating the cluster (terra-admin)
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = var.environment
    Project     = "gocart"
  }
}
