
variable "region" { 
  description = "AWS region containing the EKS cluster."
  type = string 
  default = "us-east-2"
}

variable "cluster_name" { 
  description = "EKS cluster name (not ARN)."
  type = string 
}

variable "node_group_name" {
  description = "Name to call the new Node Group."
  type = string 
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

variable "node_role_arn" {
  description = "IAM Role to attach to the nodes in the Node Group."
  type = string 
}

variable "subnet_ids" {
  description = "Subnet IDs to use for the nodes. These MUST be included in the subnets used by the EKS cluster."
  type = list(string) 
}

variable "desired_size" {
  description = "Desired size of Node Group, i.e. number of nodes expected when not scaling up."
  type = number 
  default = 3
}

variable "min_size" {
  description = "Number of nodes needed to be considered healthy. Normally if this is less than desired size, we do not expect to be running at min size unless a node had an issue."
  type = number 
  default = 2
}

variable "max_size" {
  description = "Max number of nodes. This limits the upper bound of number of nodes the scaling group will grow to."
  type = number 
  default = 8
}

variable "disk_size" {
  description = "Number of GBs for the EBS volume on the nodes. 100 means a 100GiB primary volume."
  type = number 
  default = 50
}

variable "instance_types" {
  description = "Types of nodes. This can be a list of types but normally is a single type but expressed as a list of one."
  type = list(string) 
  default = ["m6a.xlarge"]
}

variable "capacity_type" {
  description = "Tenancy of the nodes. Valid values are ON_DEMAND or SPOT."
  type = string 
  default = "ON_DEMAND"
}

variable "ami_type" {
  description = "AMI to use for the nodes. AL2023_x86_64_STANDARD should be used in most cases."
  type = string 
  default = "AL2023_x86_64_STANDARD"
}

variable "labels" {
  description = "EKS level labels to attach to the Node Group."
  type = map(string) 
}

variable "tags" {
  description = "AWS level tags to attach to the Node Group."
  type = map(string) 
}

variable "cluster_version" {
  description = "version of the cluster"
  type        = string
  default     = 1.32
}
