aws secretsmanager create-secret \
  --name argocd/gitops-repo \
  --description "ArgoCD GitHub repo credentials" \
  --secret-string '{
    "type": "git",
    "url": "https://github.com/Future-Jim/thrive-take-home.git",
    "username": "oauth2",
    "password": "REPLACE_WITH_GITHUB_PAT"
  }'