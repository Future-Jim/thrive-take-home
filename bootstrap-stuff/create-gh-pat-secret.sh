aws secretsmanager create-secret \
  --name argocd/gitops-repo-secret \
  --description "ArgoCD GitHub repo credentials" \
  --secret-string '{
    "type": "git",
    "url": "https://github.com/Future-Jim/thrive-take-home.git"
  }'