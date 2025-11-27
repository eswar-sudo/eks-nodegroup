variable "region" {
  description = "The AWS region to deploy the EKS cluster and associated resources."
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "aws_sso_role_name" {
  description = "IAM role name (SSO) to grant access to the cluster to (no ARN, no path)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs (private or public) to launch the EKS cluster and node groups."
  type        = list(string)
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS control plane. This should default to the latest version if not specified."
  type        = string
  default     = "1.33"
}

variable "node_group_name" {
  description = "The name to assign to the EKS node group."
  type        = string
}

variable "http_tokens" {
  description = "Set to 'required' to make instance metadata requests more secure."
  type        = string
  default     = "required"
}

variable "hop_limit" {
  description = "Number of network hops allowed for instance metadata requests."
  type        = number
  default     = 2
}

variable "disk_size" {
  description  = "The cluster node size of the disk in GiB"
  type         = number
  default      = 50
}

variable "desired_size" {
  description = "The desired number of nodes to launch in the node group."
  type        = number
  default      = 3
}

variable "min_size" {
  description = "The minimum number of nodes that the node group can scale down to."
  type        = number
  default      = 2
}

variable "max_size" {
  description = "The maximum number of nodes that the node group can scale up to."
  type        = number
  default      = 8
}

variable "instance_types" {
  description = "A list of EC2 instance types to use for the EKS worker nodes."
  type        = list(string)
  default     = ["m6a.xlarge"]
}

variable "capacity_type" {
  description = "The capacity type of the nodes. Valid values: ON_DEMAND or SPOT."
  type        = string
  default     = "ON_DEMAND"
}

variable "ami_type" {
  description = "The AMI type for the node group. Examples: AL2_x86_64, AL2_x86_64_GPU, BOTTLEROCKET_x86_64, AL2023_x86_64_STANDARD."
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "labels" {
  description = "A map of Kubernetes labels to apply to the EKS node group."
  type        = map(string)
}

variable "tags" {
  description = "A map of tags to apply to all AWS resources created by the module."
  type        = map(string)
}

variable "vpc_cni_version" {
  description = "Version of the VPC CNI add-on"
  type        = string
  default     = "v1.19.6-eksbuild.1"
}

variable "kube_proxy_version" {
  description = "Version of the kube-proxy add-on"
  type        = string
  default     = "v1.32.0-eksbuild.2"
}

variable "coredns_version" {
  description = "Version of the CoreDNS add-on"
  type        = string
  default     = "v1.11.4-eksbuild.2"
}

variable "cluster_inbound_cidrs" {
  description = "CIDRs to allow inbound to the cluster. In DCLI, this is normally just 10.0.0.0/8."
  type        = list(string)
  default     = ["10.0.0.0/8"]
}
