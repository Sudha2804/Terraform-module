module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  #version = "19.17.0"
 
 

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  
 

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa = true
 

  eks_managed_node_groups = {
    worker_group_1 = {
      node_role_arn  = aws_iam_role.eks_node_role.arn
      desired_size   = var.node_desired_size
      max_size       = var.node_max_size
      min_size       = var.node_min_size
      instance_types = [var.node_instance_type]
      capacity_type  = "ON_DEMAND"
    }
  }

}
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
