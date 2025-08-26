#!/bin/bash
set -euo pipefail

ROLE_NAME="GitHubActionsTofuRole"
POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"

# Create role if it doesn't exist
if ! aws iam get-role --role-name "$ROLE_NAME" >/dev/null 2>&1; then
  echo "Creating role: $ROLE_NAME"
  aws iam create-role \
    --role-name "$ROLE_NAME" \
    --assume-role-policy-document file://trust-policy.json  >/dev/null
  sleep 5 # give IAM time to propagate
else
  echo "Role $ROLE_NAME already exists, skipping creation"
fi

# Attach policy if not already attached
if ! aws iam list-attached-role-policies --role-name "$ROLE_NAME" \
   | grep -q "$POLICY_ARN"; then
  echo "Attaching policy to role: $ROLE_NAME"
  aws iam attach-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-arn "$POLICY_ARN"
else
  echo "Policy already attached to $ROLE_NAME"
fi