provider "aws" {
  region = var.region
}

module "nodegroup" {
  source           = "spacelift.io/dcli/eks-nodegroup/default"
  version          = "0.2.5"
#  cluster_name     = var.cluster_name
  cluster_name     = aws_eks_cluster.this.name
  subnet_ids       = var.subnet_ids
  node_group_name  = var.node_group_name
  node_role_arn    = aws_iam_role.eks_node_role.arn
  disk_size        = var.disk_size
  desired_size     = var.desired_size
  min_size         = var.min_size
  max_size         = var.max_size
  http_tokens      = var.http_tokens
  hop_limit        = var.hop_limit
  instance_types   = var.instance_types
  capacity_type    = var.capacity_type
  ami_type         = var.ami_type
  tags             = var.tags
  labels           = var.labels
  region           = var.region
}

data "aws_iam_role" "sso_role" {
  name = var.aws_sso_role_name
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = var.tags
}
resource "aws_eks_access_entry" "root" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = data.aws_iam_role.sso_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "root_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.root.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "root_cluster_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.root.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-EKS-Node-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ])
  role       = aws_iam_role.eks_node_role.name
  policy_arn = each.value
}

# Fetch EKS cluster details to get the cluster SG ID
data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}

resource "aws_security_group_rule" "allow_ports_to_cluster" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = data.aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  cidr_blocks       = var.cluster_inbound_cidrs

  depends_on        = [aws_eks_cluster.this]
}
