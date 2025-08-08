region         = "us-east-1"
cluster_name   = "dynatrace-karpenter"
#vpc_cidr       = "10.30.0.0/16"
#azs            = ["us-east-2b", "us-east-2a"]
subnet_ids     = ["subnet-08f4908e4486bfee3", "subnet-082f5d7ce7b741455"]
cluster_version = "1.33"
node_group_name = "system-nodes"
node_role_arn  = "arn:aws:iam::575958559853:role/KarpenterNodeRole-dynatrace-karpenter"
min_size        = 1
max_size        = 4
desired_size    = 3
instance_types  = ["t3.medium"]
capacity_type   = "ON_DEMAND"
ami_type        = "AL2023_x86_64_STANDARD"
attach_primary_sg = "sg-04f7894e4a701b5d9"
labels = {
  "nodegroup" = "system-nodes"
}
tags = {
  Environment = "dev"
  Owner       = "582683034382"
}

environment   = "dev"

