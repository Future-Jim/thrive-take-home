# argocd.tf
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.12" 
  namespace  = "argocd"

  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  wait    = true
  atomic  = true
  timeout = 600



}

