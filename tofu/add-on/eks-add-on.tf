module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.19.0"
  #
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  cluster_version    = var.cluster_version
  oidc_provider_arn  = var.oidc_provider_arn

  # Enable AWS LB Controller
  enable_aws_load_balancer_controller = true

  aws_load_balancer_controller = {
    namespace = "kube-system"
    values = [<<-EOT
      clusterName: "thrive-eks"
      region: ${var.region}
      vpcId: ${var.vpc_id}
    EOT
    ]
  }

}