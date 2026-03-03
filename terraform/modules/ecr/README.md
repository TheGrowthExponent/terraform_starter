# ECR Module

This module provisions an AWS Elastic Container Registry (ECR) repository and associates it with an ECS role. It is designed to be reusable for containerized application deployments.

## Usage

```hcl
module "ecr" {
  source        = "../ecr"
  repository_name = "my-app-repo"
  ecs_role_arn    = aws_iam_role.ecs_role.arn
}
```

## Inputs

| Name            | Description                        | Type     | Required | Default |
|-----------------|------------------------------------|----------|----------|---------|
| repository_name | The name of the ECR repository     | string   | yes      | n/a     |
| ecs_role_arn    | The ECS role ARN                   | string   | yes      | n/a     |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                      |
|----------------|----------------------------------|
| ecr_repository | The ECR repository resource      |

## Example

```hcl
module "ecr" {
  source          = "../ecr"
  repository_name = "my-app-repo"
  ecs_role_arn    = "arn:aws:iam::123456789012:role/ecs-role"
}
```

## Notes

- Ensure the ECS role has permissions to interact with the ECR repository.
- The repository name should be unique within your AWS account.
- You may want to configure lifecycle policies or image scanning as needed.

## License

See the root LICENSE file for details.