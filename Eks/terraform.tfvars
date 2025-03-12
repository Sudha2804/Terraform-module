aws_region       = "ap-south-1"
cluster_name     = "my-eks-cluster"
cluster_version  = "1.31"
vpc_id           = "vpc-09c42d34ce64e8755"
subnet_ids       = ["subnet-08ce24fbae9ee29ab","subnet-0e1412e352f2eccaa"]
node_instance_type = "t2.medium"
node_desired_size = 2
node_max_size     = 3
node_min_size     = 1
eks_cluster_role_name = "arn:aws:eks:ap-south-1:676206928284:cluster/eks_demo"
eks_node_role_name    = "arn:aws:iam::676206928284:role/AmazonEKSAutoNodeRole"

