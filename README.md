# Terraform Starter Kit

To the run the following commands from your terminal you require to have the
Terraform CLI installed locally. For single user development this is ok, but do not use
the CLI for UAT, PPD or Production

Terraform uses an encrypted Amazon S3 backend for remote state. Configure AWS
credentials with least-privilege access to the state bucket before running
Terraform. The environment-specific backend settings are stored in
`terraform/backend-dev.hcl`; do not fall back to local state.

From the repository root:

```bash
cd terraform
terraform init -upgrade -backend-config=backend-dev.hcl
```

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
