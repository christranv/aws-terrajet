<img style="text-align: center;" src="images/logo.png"/>
<h1 style="text-align: center;">Built For Your Monolith</h1>

TerraJet follows [AWS][aws] best practices to help your infrastructure archives reliability, security, performance, and cost optimization. Save your time on researching and deploying. TerraJet will give you the easiest way to approach Infrastructure as Code (IaC) frameworks like Terraform.

**Table of Contents**
- [Features](#features)
- [Design](#design)
- [Supported modules](#supported-modules)
- [Frequently Asked Questions](#frequently-asked-questions)
	- [Q: Why ECS is used for deploying monolith app?](#q-why-ecs-is-used-for-deploying-monolith-app)

## Features
- Support deploying Single-page application (React, Angular, Vue) to S3 and cached by CloudFront.
- Support deploying SQL database to RDS.
- Support deploying and automatic scaling **Dockerized** API app to ECS cluster.
- Enable Role-Based Access Control for API app.
- Enable spot instance mode in ECS to minimize computing cost.
- Provide TLS/SSL certificate with ACM
- Provide Microservices adaptability for your future growth.

## Design
![diagram](images/diagram.png)

## Supported modules

These AWS Terraform modules are supported by current version.

| Name                | Description           |
| ------------------- | --------------------- |
| [VPC][vpc]          | Virtual Private Cloud |
| [SecurityGroup][sg] | Security Group        |
| [S3][s3]            | S3                    |
| [CloudFront][cf]    | CloudFront            |
| [RDS][rds]          | RDS                   |
| [EC2][ec2]          | EC2 Instance          |
| [Route53][r53]      | Route 53              |

## Frequently Asked Questions
### Q: Why ECS is used for deploying monolith app?
[TODO] Answer here

[aws]: https://aws.amazon.com/
[vpc]: ./modules/vpc
[sg]: ./modules/security-group
[s3]: ./modules/s3
[cf]: ./modules/cloudfront
[rds]: ./modules/rds
[ec2]: ./modules/ec2
[r53]: ./modules/route-53
