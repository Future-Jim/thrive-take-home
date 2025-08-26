# thrive-take-home

![Alt text](./images/diagram.png)

## Run bootstrap scripts
1. Authenticate to AWS Account via CLI
2. Update <ACCOUNT_NUMBER> on line 7 of bootstrap-stuff/trust-policy.json
3. Run create-oidc-role.sh. 
4. Run enable-oidc.sh
5. Run create-s3-backend.sh and take note of the __s3 bucket__ in the output
6. Run create-gh-pat-secret.sh
    - __Prior__ to running this, obtain a GH PAT token for __this__ repo (see here: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
    - This is necessary since our "gitops" repo is private and requires authentication. (ahem secrets manager ;-) )
6. Update tofu/infra/config/dev.tfvars variables
6. Update tofu/add-on/config/dev.tfvars variables
8. Update the provider config in /tofu/infra/providers.tf for the terraform backend with the S3 bucket name 
8. Update the provider config in /tofu/add-on/providers.tf for the terraform backend with the S3 bucket name (key is harcoded)
9. Update account number in apps/hello-app/kustomization.yaml
10. In the GitHub repo, update the environment variable AWS_ACCOUNT_ID to your AWS account. 
11. Should be good to push code to github now and run ci/cd jobs


Notes:
- Deploy job needs to be run twice (need to fix this somehow)

##### To access ArgoCD UI
1. Obtain default admin password (user is admin)
2. kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
3. Port forward argocd service
   - kubectl port-forward service/argocd-server -n argocd 8080:443 
5. Visit localhost:8080.

##### To access Grafana UI
1. Default user and password are both "admin"
2. Port forward grafana
    - kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 9090:9090
3. Visit localhost:9090


##### Tradeoffs
- Ingress is only working for the web app. We would need additional configurations to make other apps work with this ingress.
- ArgoCD and Grafana are not accessible via ingress. We could make them accessible over ingress too. 
- We could automate the manual update of hardcoded variables in the steps above (its error prone and annoying)
- 