# DynamoDB Module

This module provisions an AWS DynamoDB table with customizable table name and tags. It is designed to be reusable for different environments and applications.

## Usage

```hcl
module "dynamodb" {
  source     = "../dynamodb"
  table_name = "my-app-table"
  tags = {
    purpose = "app-data"
    owner   = "team"
  }
}
```

## Inputs

| Name       | Description         | Type         | Required | Default |
|------------|---------------------|--------------|----------|---------|
| table_name | DDB table name      | string       | yes      | n/a     |
| tags       | DDB tags            | map(string)  | yes      | n/a     |

## Outputs

| Name           | Description                |
|----------------|---------------------------|
| aws_dynamodb_table | The DynamoDB table resource |

## Features

- Creates a DynamoDB table with the specified name.
- Tags resources for organization and cost allocation.

## Example

```hcl
module "dynamodb" {
  source     = "../dynamodb"
  table_name = "user-data"
  tags = {
    purpose = "users"
    owner   = "dev-team"
  }
}
```

## Notes

- Customize the table name and tags as needed for your application.
- Additional table configuration (attributes, indexes, etc.) can be added by extending the module.

## License

See the root LICENSE file for details.
