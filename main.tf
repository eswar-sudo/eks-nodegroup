provider "aws" {
region = var.region
}

# Node group module main.tf
resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  subnet_ids      = (var.subnet_ids)
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

   scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  ami_type       = var.ami_type

  tags = var.tags

  labels = var.labels

  #lifecycle {
   # ignore_changes = all
 # }
}
