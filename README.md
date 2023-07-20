<img style="text-align: center;" src="images/logo.png"/>
<h2>Built For Your Monolith</h2>

TerraJet follows [AWS][aws] best practices to help your infrastructure archives reliability, security, performance, and cost optimization. Save your time on researching and deploying. TerraJet provide the easiest way to approach Infrastructure as Code (IaC) frameworks like Terraform.

![terraform](https://img.shields.io/badge/Terraform-1%2E5%2E2-5b4de3?style=flat-square&logo=terraform&logoColor=white)&nbsp;
![aws](https://img.shields.io/badge/AWS%20Provider-5%2E3%2E7-FF9900?style=flat-square&logo=amazon-aws&logoColor=white)&nbsp;
![docker](https://img.shields.io/badge/Docker-latest-2CA5E0?style=flat-square&logo=docker&logoColor=white)&nbsp;
![nodejs](https://img.shields.io/badge/Node.js-18-3C873A?style=flat-square&logo=nodedotjs&logoColor=white)

**Table of Contents**
- [Features](#features)
- [Design](#design)
- [Supported modules](#supported-modules)
- [Installation](#installation)
- [FAQ](#faq)
	- [Q: Why ECS is used for monolith app?](#q-why-ecs-is-used-for-monolith-app)

## Features
- Support deploying Single-page application (React, Angular, Vue) to S3 and cached by CloudFront.
- Support deploying SQL database to RDS.
- Support deploying and automatic scaling **Dockerized** API to ECS cluster.
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

[aws]: https://aws.amazon.com/
[vpc]: ./modules/vpc
[sg]: ./modules/security-group
[s3]: ./modules/s3
[cf]: ./modules/cloudfront
[rds]: ./modules/rds
[ec2]: ./modules/ec2
[r53]: ./modules/route-53

## Installation

## FAQ
### Q: Why ECS is used for monolith app?
[TODO] Answer here
