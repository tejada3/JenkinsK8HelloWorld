variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  default     = "default"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "flask-eks-cluster"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Number of worker nodes"
  default     = 2
}
