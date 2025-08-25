module "alb_irsa" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                = "~> 5.30"
  role_name                              = "${var.project_name}-alb-controller"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
  tags = local.tags
}


# module "fluent_irsa" {
#   source           = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version          = "~> 5.30"
#   role_name        = "${var.project_name}-fluent-bit"
#   role_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]
#   oidc_providers = {
#     main = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["logging:aws-for-fluent-bit"]
#     }
#   }
#   tags = local.tags
# }