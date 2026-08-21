# Terraform Starter Kit (non-deploying template)

This repository is a reusable Terraform template. It is not an environment and must not be used to create cloud resources or remote state. Read [AGENTS.md](AGENTS.md) and [SKILL.md](SKILL.md) before making changes.

When this template is copied into a real project, the project owner must replace this README with project-specific documentation and add an explicit project identity marker. Until then, treat every checkout as template-safe.

To the run the following commands from your terminal you require to have the
Terraform CLI installed locally. For single user development this is ok, but do not use
the CLI for UAT, PPD or Production

Do not run `terraform init` with a backend configuration, `terraform plan`,
`terraform apply`, or `terraform destroy` from this template. Backend examples
are reference material for a future project conversion only.

<span style="color: red">DO NOT</span> commit your _terraform-dev.tfvars_ file to GitHub
as it contains sensitive information. It should only be used for local development.

## Safe local checks

```bash
terraform fmt -check -recursive terraform
terraform validate -json -no-color
```

These checks must remain local and must not be used to configure a live backend.

## Linting
```bash
python -m venv .venv
source .venv/bin/activate
pip install pre-commit
pre-commit install
pre-commit run --all-files
```
