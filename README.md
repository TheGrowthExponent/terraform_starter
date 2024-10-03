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

## Linting
```bash
python -m venv .venv
source .venv/bin/activate
pip install pre-commit
pre-commit install
pre-commit run --all-files
```
