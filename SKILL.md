# Terraform starter repository skill

Use this workflow whenever working in this repository or in a repository created from it.

## 1. Classify before acting

Run read-only checks first:

```bash
git remote -v
git status --short
```

Classify the checkout as **template** when its origin is the upstream starter repository (`TheGrowthExponent/terraform_starter`), when the README still identifies it as a starter kit, or when no project identity marker exists. Classify it as **project** only when the remote, README, and an explicit project marker consistently identify a real project. If any check conflicts, use the template-safe path and ask for confirmation before deployment-related work.

## 2. Template-safe operations

The template is documentation and reusable infrastructure code; it is not an environment. Never create resources or state from it. Do not run backend initialization, plan, apply, or destroy. Do not use real credentials or production values.

Allowed checks are local/static operations such as:

```bash
terraform fmt -check -recursive terraform
terraform validate -json -no-color
pre-commit run --all-files
```

Validation must not be used as a reason to configure a live backend. If provider installation requires credentials or network access, report the gap instead of bypassing the safety gate.

## 3. Converting a copy into a project

A project owner must explicitly complete these steps:

1. Set a project-specific repository name and remote.
2. Replace the starter README with project purpose, ownership, environments, prerequisites, backend ownership, and safe operating procedures.
3. Add a project marker in the README (for example, `Repository type: project`) and record the approved AWS account/region and state backend without secrets.
4. Review every variable, module input, provider constraint, IAM permission, and environment file.
5. Configure an approved remote backend and CI identity using least privilege; never commit credentials or real `.tfvars` files.
6. Run a plan in the intended non-production environment and obtain review before any apply.

Only after all six steps may project-specific instructions permit `terraform init`, `plan`, or `apply`. Destruction requires a separate, explicit approval and a reviewed plan.

## 4. Documentation rule

When classified as a project, replace the template README rather than appending project instructions beneath it. When classified as the template, keep the README template-oriented and clearly state that it does not deploy resources.

