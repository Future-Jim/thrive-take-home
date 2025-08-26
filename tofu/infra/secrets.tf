resource "kubernetes_secret" "argocd_repo" {
  metadata {
    name      = "gitops-repo"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    type     = local.argocd_repo_secret["type"]
    url      = local.argocd_repo_secret["url"]
    username = local.argocd_repo_secret["username"]
    password = local.argocd_repo_secret["password"]
  }

  depends_on = [helm_release.argocd]
}

data "aws_secretsmanager_secret_version" "argocd_repo" {
  secret_id = "argocd/gitops-repo" 
}

locals {
  argocd_repo_secret = jsondecode(data.aws_secretsmanager_secret_version.argocd_repo.secret_string)
}