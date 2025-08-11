region         = "us-east-1"
cluster_name   = "eks-tf-spacelift"
#vpc_cidr       = "10.30.0.0/16"
#azs            = ["us-east-2b", "us-east-2a"]
subnet_ids     = ["subnet-02ce4a54aa63e172d", "subnet-0ff098c2e55f3b9cf"]
cluster_version = "1.33"
node_group_name = "linux-nodes"
node_role_arn  = "arn:aws:iam::575958559853:role/eks-tf-spacelift-node-role"
min_size        = 1
max_size        = 4
desired_size    = 3
instance_types  = ["t3.medium"]
capacity_type   = "ON_DEMAND"
ami_type        = "AL2023_x86_64_STANDARD"
attach_primary_sg = "sg-03b45ef9b97c9c7f8"
labels = {
  "nodegroup" = "system-nodes"
}
tags = {
  Environment = "dev"
  Owner       = "582683034382"
}

environment   = "dev"

