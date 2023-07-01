# Terraform AWS Template

A set of Terraform predefined modules used for provisioning web application stacks on [AWS](https://aws.amazon.com/).

![diagram](images/diagram.png)

The templates are used for creating and managing AWS infrastructure.

## Supported Services

These AWS services are supported by current version.

| Name       | Description           |
| ---------- | --------------------- |
| VPC        | Virtual Private Cloud |
| S3         | S3                    |
| CloudFront | CloudFront            |
| EC2        | EC2 Instance          |

### Components

These components are shared by all environments.

| Name              | Description                   | Optional |
| ----------------- | ----------------------------- | :------: |
| [provider.tf][mp] | AWS provider                  |          |
| [main.tf][mm]     | AWS provider, output          |          |
| [outputs.tf][mo]  | Output variables after deploy |          |  |

[aws]: https://aws.amazon.com/
[mp]: ./provider.tf
[mm]: ./main.tf
[mo]: ./outputs.tf