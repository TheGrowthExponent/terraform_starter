# Repository operating instructions

This repository is a Terraform starter template. It must not be initialized against a live backend, planned, applied, or destroyed while it is still the template repository.

## Identify the repository type first

Before running Terraform or changing documentation, determine whether this checkout is:

- **The template**: the repository remote identifies `TheGrowthExponent/terraform_starter`, or the repository still has the starter-kit identity and no project marker.
- **A project repository**: the template has been copied/forked and the project has an explicit identity (project name, owner, environment, and approved backend configuration) recorded in its own README.

If the result is ambiguous, treat it as the template. Do not infer project status from a local directory name.

## Template safety gate

For the template repository:

- Do not run `terraform init` with a backend configuration.
- Do not run `terraform plan`, `terraform apply`, or `terraform destroy`.
- Do not add real account IDs, domains, credentials, state-bucket names, or environment values.
- Limit changes to module examples, documentation, formatting, static validation, and tests that do not contact a cloud provider.

Use the repository skill in `SKILL.md` for the complete decision process.

## Project conversion

When a consumer intentionally converts a copy into a project repository, follow `SKILL.md`. Replace the starter README with project-specific documentation only after the project identity and remote backend have been confirmed. Keep secrets and real environment files out of Git.

