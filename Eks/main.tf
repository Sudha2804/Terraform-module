provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    bucket  = "atarv-sudha-s3-1"
    key     = "eks-cluster/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

# Call EKS Module
module "eks" {
  source = "./modules/eks"

  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version

  vpc_id           = var.vpc_id
  subnet_ids       = var.subnet_ids
  node_instance_type = var.node_instance_type
  node_desired_size = var.node_desired_size
  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  eks_cluster_role_name = var.cluster_name
  eks_node_role_name    = var.eks_node_role_name  
}


