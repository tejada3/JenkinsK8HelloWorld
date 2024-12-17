# VPC Module
module "vpc" {
  source  = ".terraform/modules"
  version = "5.0"

  name                 = "eks-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

# EKS Cluster
module "eks" {
  source          = ".terraform/modules"
  version         = "19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    flask-app-ng = {
      instance_types = [var.node_instance_type]
      desired_capacity = var.desired_capacity
    }
  }

  tags = {
    Environment = "dev"
    Project     = "flask-app"
  }
}
