# Terraform 
```bash
aws cloudformation describe-stacks --stack-name tf-aurora-pgsql-state --query 'Stacks[0].Outputs' | \
jq '{bucket: (.[] | select(.OutputKey == "StateBucketName").OutputValue), 
     dynamodb_table: (.[] | select(.OutputKey == "LockTableName").OutputValue),
     encrypt: "true",
     kms_key_id: (.[] | select(.OutputKey == "KmsKeyId").OutputValue),
     region: (.[] | select(.OutputKey == "Region").OutputValue),
     role_arn: (.[] | select(.OutputKey == "RoleArn").OutputValue)}' > terraform-init.tfvars.json

```

```bash
docker run --rm -it -v ${PWD}:/terraform -w=/terraform --user "$(id -u):$(id -g)" -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN hashicorp/terraform:latest init -backend-config=/terraform/terraform-init.tfvars.json
```

This should not trigger TF changes.# terraform-ct-immersion-day-aft


# Errors

## Missing Terraform

If you follow up on Creating Cloud9 instance in management account to run terraform. You might need to install terraform.


## Roles missing Permissions

Solution attached to aft-codepipeline-customizations-role, aft-codebuild-customizations-role IAM polcicy arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess

```
Error: creating CodeBuild Project (aft-global-customizations-terraform): operation error CodeBuild: CreateProject, https response error StatusCode: 400, RequestID: ff678a1f-0d83-41e2-a34b-83c5914431b1, InvalidInputException: Not authorized to perform DescribeSecurityGroups
```