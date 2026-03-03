# S3 Module

This module provisions an AWS S3 bucket with optional public access for static website hosting. It supports tagging and can be used for both private and public buckets.

## Usage

```hcl
module "s3_bucket" {
  source      = "../s3"
  bucket_name = "my-app-bucket"
  tags        = {
    purpose = "Application storage"
    owner   = "team"
  }
  public      = true # Set to true for web hosting
}
```

## Inputs

| Name        | Description                                         | Type         | Default  | Required |
|-------------|-----------------------------------------------------|--------------|----------|----------|
| bucket_name | S3 bucket to create                                 | string       | n/a      | yes      |
| tags        | S3 bucket tags                                      | map(string)  | n/a      | yes      |
| public      | Enable public access for S3 bucket (web hosting)    | bool         | false    | no       |

## Outputs

| Name           | Description                |
|----------------|---------------------------|
| aws_s3_bucket  | The S3 bucket resource    |

## Features

- Creates an S3 bucket with versioning and ownership controls.
- Optionally enables public read access for static website hosting.
- Tags resources for organization.
- Metrics enabled for bucket monitoring.

## Example: Private Bucket

```hcl
module "private_bucket" {
  source      = "../s3"
  bucket_name = "my-private-bucket"
  tags        = {
    purpose = "private"
  }
  public      = false
}
```

## Example: Public Bucket for Web Hosting

```hcl
module "public_bucket" {
  source      = "../s3"
  bucket_name = "my-public-site"
  tags        = {
    purpose = "web"
  }
  public      = true
}
```

## Notes

- When `public` is set to `true`, a bucket policy is attached to allow public read (`s3:GetObject`) access.
- When `public` is `false`, all public access is blocked.
- Make sure to configure your bucket for static website hosting if you intend to serve web content.

## License

See root LICENSE file.