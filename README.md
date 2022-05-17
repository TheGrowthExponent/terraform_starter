### Initialize Terraform env
```bash
terraform init
```

### Format and Validate Templates
```bash
terraform fmt && terraform validate
```
This should output "Success! The configuration is valid."

### Create Terraform Plan
Specify dev, test or prod config file
```bash
# specify dev/test/prod
terraform plan -out=".terraform_plan_dev" -var-file terraform-dev.tfvars
```

### Apply Terraform Plan
```bash
# specify dev/test/prod
terraform apply ".terraform_plan_dev"
```

### List Terraform Created Resources
```bash
terraform state list
```

### Show The Latest Changes
```bash
terraform show
```

### Show All Outputs
```bash
terraform output
```

### Destroy Terraform Resources - This will remove everything so don't use in production
```bash
terraform destroy -var-file terraform-dev.tfvars
```
