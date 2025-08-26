terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws        = { source = "hashicorp/aws", version = ">= 6.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = ">= 2.37" }
    helm = { source  = "hashicorp/helm", version = ">= 2.12, < 3.0"
    }
  }

  backend "s3" {
    bucket       = "tf-backend-4232"
    key          = "thrive/add-on/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}


provider "aws" { region = var.region }


# ------------------------
# Data source for cluster auth
# ------------------------
data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }
}