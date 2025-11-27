# Configure the AWS Provider
provider "aws" {
  region = var.region 
}

resource "aws_launch_template" "ng" {
  name_prefix   = "${var.node_group_name}-"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.disk_size
      volume_type = "gp3"
      delete_on_termination = true
    }
  }

   metadata_options {
    http_tokens = var.http_tokens
    http_put_response_hop_limit = var.hop_limit
  }
    
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-${var.node_group_name}"
      
    }
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  version         = var.cluster_version
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  #disk_size       = var.disk_size

  launch_template {
    id      = aws_launch_template.ng.id
    version = aws_launch_template.ng.latest_version
    //version = "$Latest"
  }
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = var.instance_types
  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  labels         = var.labels
  tags           = var.tags
}
