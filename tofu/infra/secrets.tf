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
    type     = "git"
    url      = "https://github.com/Future-Jim/thrive-take-home.git"
    username = "oauth2"
    password =  "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"
  }

  depends_on = [helm_release.argocd]
}