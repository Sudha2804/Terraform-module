variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}
variable "eks_cluster_role_name" {
  description = "IAM role name for the EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_node_role_name" {
  description = "IAM role name for the EKS worker nodes"
  type        = string
  default     = "eks-node-role"
}

