module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.cluster_name}"
  kubernetes_version = "1.33"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 4
      desired_size = 3
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

}

# Role is hardcoded to match what is in bootstrap step. Be careful :)
resource "aws_eks_access_policy_association" "gha_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::${var.aws_account_id}:role/GitHubActionsTofuRole"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "cloud_user" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::${var.aws_account_id}:user/cloud_user"
  type          = "STANDARD"
}

# Bind the role to EKS ClusterAdmin (full cluster access)
resource "aws_eks_access_policy_association" "cloud_user_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.cloud_user.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}


