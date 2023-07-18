# Terraform AWS Template

This template is built to help you provision [AWS](https://aws.amazon.com/) services that you need for your monolith web application. Save your time on researching and deploy infrastructure with IaC tool like Terraform.
## Features:
- Support deploying Single-page application (React, Angular, Vue) to S3 and cached by CloudFront.
- Support deploying and scaling **Dockerized** API app to ECS cluster.
- Provide role-based access control for API app.
- Support deploying SQL database to RDS.
- Provide TLS/SSL certificate with ACM
- Provide Microservices adaptability for your future growth.

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

## Components

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
