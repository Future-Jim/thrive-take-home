# thrive-take-home

## Run bootstrap scripts
1. Authenticate to AWS Account via CLI
2. Update <ACCOUNT_NUMBER> on line 7 of bootstrap-stuff/trust-policy.json
3. Run create-oidc-role.sh. 
4. Run enable-oidc.sh
5. Run create-s3-backend.sh and take note of the *s3 bucket* in the output
6. Update tofu/infra/config/dev.tfvars variables
6. Update tofu/add-on/config/dev.tfvars variables
8. Update the providera config in /tofu/infra/providers.tf for the terraform backend with the S3 bucket name 
8. Update the providera config in /tofu/add-on/providers.tf for the terraform backend with the S3 bucket name 
9. Update account number in apps/hello-app/kustomization.yaml
10. In the GitHub repo, update the environment variable AWS_ACCOUNT_ID to your AWS account. 
11. Should be good to push code to github now and run ci/cd jobs


Notes:
- Deploy job needs to be run twice (need to fix this somehow)

##### To access ArgoCD UI
1. Obtain default admin password 
2. kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
3. Port forward argocd service
4. kubectl port-forward service/argocd-server -n argocd 8080:443 
5. Visit localhost:8080.

##### TODO
1. fix pipelines -> they should have a separate plan section. Currently a push is meaningless and only manually triggered jobs do anything useful for the deploy-infra job.