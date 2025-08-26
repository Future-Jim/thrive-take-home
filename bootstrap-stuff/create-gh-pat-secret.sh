aws secretsmanager create-secret \
  --name argocd/gitops-repo \
  --description "ArgoCD GitHub repo credentials" \
  --secret-string '{
    "type": "git",
    "url": "https://github.com/Future-Jim/thrive-take-home.git",
    "username": "oauth2",
    "password": "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"
  }'