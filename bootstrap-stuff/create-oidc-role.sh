aws iam create-role \
  --role-name GitHubActionsTofuRole \
  --assume-role-policy-document file://trust-policy.json

aws iam attach-role-policy \
  --role-name GitHubActionsTofuRole \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess