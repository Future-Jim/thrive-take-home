terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws        = { source = "hashicorp/aws", version = ">= 6.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = ">= 2.37" }
    helm = { source  = "hashicorp/helm", version = ">= 2.12, < 3.0"
    }
  }

  backend "s3" {
    bucket       = "tf-backend-15690"
    key          = "thrive/infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" { region = var.region }

# -------------------------
# Data source for cluster auth
# -------------------------
data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

# ------------------------
# Helm provider
# ------------------------
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}