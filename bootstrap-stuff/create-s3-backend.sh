#!/usr/bin/env bash
set -euo pipefail

# --- config ---
AWS_REGION="us-east-1"              # change if needed
BUCKET_NAME="tf-backend-$RANDOM"    # must be globally unique, customize as needed

echo "Creating S3 bucket: $BUCKET_NAME in $AWS_REGION"

# Create the bucket
aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$AWS_REGION" \

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled

# Enable default encryption
aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }
    ]
  }'

echo "S3 backend bucket $BUCKET_NAME created and configured."
echo ""
echo "Use this in your backend config:"
echo "terraform {"
echo "  backend \"s3\" {"
echo "    bucket = \"$BUCKET_NAME\""
echo "    key    = \"thrive/terraform.tfstate\""
echo "    region = \"$AWS_REGION\""
echo "  }"
echo "}"
