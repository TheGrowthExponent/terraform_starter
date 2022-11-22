# Terraform Starter Kit

To the run the following commands from your terminal you require to have the
Terraform CLI installed locally. For single user development this is ok, but do not use
the CLI for UAT, PPD or Production

It is possible to use GitHub workflows to deploy Terraform code and an example
is included, with the deployment components commented out. If deploying from
GitHub workflows, you need to maintain the current state yourself in an S3 bucket.

The preferred method is to use Terraform Cloud https://app.terraform.io/ for all
deployments, as this is more suited to larger enterprise teams.
Terraform Cloud will automatically deploy your infrastructure and manage
the state of your deployed infrastructure.

<span style="color: red">DO NOT</span> commit your _terraform-dev.tfvars_ file to GitHub
as it contains sensitive information. It should only be used for local development.

## CLI Commands

### Initialize Terraform env

```bash
terraform init -upgrade 
```

### Format and Validate Templates

```bash
terraform fmt -recursive
terraform validate
```

This should output "Success! The configuration is valid."

### Rename local variable file

If you are testing or deploying from your local CLI then rename the example var file
terraform-dev.tfvars.example to terraform-dev.tfvars and update with required values

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
