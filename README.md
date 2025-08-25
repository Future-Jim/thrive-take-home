# thrive-take-home

## 1. Run bootstrap scripts against your AWS account via CLI
### 1.1 Update <ACCOUNT_NUMBER> on line 7 of trust-policy.json
#### Update <ACCOUNT_NUMBER> in config/dev.tfvars
### 1.2 Run create-oidc-role.sh. 
### 1.3 Run enable-oidc.sh
### 1.4 Run create-s3-backend.sh and take note of the s3 bucket and key in the output
### 1.5 Update infra/tofu/config/dev.tfvars variables as follows
#### s3_bucket and s3_key from step 1.4
### 1.6 Update the provider config for the terraform backend with the S3 bucket name and S3 key name 
### 1.7 In the GitHub repo, update the environment variable AWS_ACCOUNT_ID to your AWS account. This is necessary for OICD
### Should be good to push code to github now and run ci/cd jobs


TODO
1. remove hardcoded vpc in add-on eks load balancer
2. fix pipelines -> they should have a separate plan section