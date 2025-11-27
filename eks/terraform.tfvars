region           = "us-east-2"
cluster_name     = "eks-tf-spacelift"
aws_sso_role_name = "AWSReservedSSO_AdministratorPermissionSet_abc1234"
vpc_id           = "vpc-0bcd4b4b3953ce45c"
subnet_ids       = ["subnet-0abcd", "subnet-0xyz"]
cluster_version  = "1.33"
node_group_name  = "system-ng"
disk_size        = 50
desired_size     = 1
min_size         = 1
max_size         = 3
instance_types   = ["t3.medium"]
capacity_type    = "ON_DEMAND"
ami_type         = "AL2023_x86_64_STANDARD"
vpc_cni_version           = "v1.19.6-eksbuild.1"
coredns_version           = "v1.11.4-eksbuild.2"
kube_proxy_version        = "v1.32.0-eksbuild.2"


labels = {
  nodegroup = "system"
}

tags = {
  Environment = "dev"
  Terraform   = "true"
}
