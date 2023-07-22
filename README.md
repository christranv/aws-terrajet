<img style="text-align: center;" src="images/logo.png"/>
<h2>Built For Your Monolith</h2>

TerraJet follows [AWS][aws] best practices to help your infrastructure archives reliability, security, performance, and cost optimization. Save your time on researching and deploying. TerraJet provide the easiest way to approach Infrastructure as Code (IaC) frameworks like Terraform.

![terraform](https://img.shields.io/badge/Terraform-1%2E5%2E2-5b4de3?style=flat-square&logo=terraform&logoColor=white)&nbsp;
![aws](https://img.shields.io/badge/AWS%20Provider-5%2E3%2E7-d48101?style=flat-square&logo=amazon-aws&logoColor=white)&nbsp;
![aws-cli](https://img.shields.io/badge/aws--cli-2%2E13%2E0-d48101?style=flat-square&logo=amazon-aws&logoColor=white)&nbsp;
![docker](https://img.shields.io/badge/Docker-latest-2CA5E0?style=flat-square&logo=docker&logoColor=white)&nbsp;
![nodejs](https://img.shields.io/badge/Node.js-18-3C873A?style=flat-square&logo=nodedotjs&logoColor=white)

**Table of Contents**
- [Features](#features)
- [Design Diagram](#design-diagram)
- [Supported modules](#supported-modules)
- [Installation](#installation)
- [FAQ](#faq)
	- [Q: Why ECS is used for monolith app?](#q-why-ecs-is-used-for-monolith-app)
	- [Q: Why is ECS but not Kubernetes?](#q-why-is-ecs-but-not-kubernetes)

## Features
- Support deploying Single-page application (React, Angular, Vue) to S3 and cached by CloudFront.
- Support deploying SQL database to RDS.
- Support deploying and automatic scaling **Dockerized** API to ECS cluster.
- Enable Role-Based Access Control for API app.
- Enable spot instance mode in ECS to minimize computing cost.
- Provide TLS/SSL certificate with ACM
- Provide Microservices adaptability for your future growth.

## Design Diagram
![diagram](images/diagram.png)

## Supported modules
These AWS Terraform modules are supported by current version.

| Name                   | Description                       |
| ---------------------- | --------------------------------- |
| [IAM][iam]             | Identity and Access Management    |
| [Policy][plc]          | IAM Policy                        |
| [VPC][vpc]             | Virtual Private Cloud             |
| [SecurityGroup][sg]    | Security Group                    |
| [S3][s3]               | S3                                |
| [CloudFront][cf]       | CloudFront                        |
| [RDS][rds]             | Relational Database Service (RDS) |
| [KeyPair][kp]          | EC2 KeyPair                       |
| [EC2][ec2]             | EC2                               |
| [ECR][ecr]             | Elastic Container Registry        |
| [ECS][ecs]             | Elastic Container Service         |
| [ELB][elb]             | Elastic Load Balancer             |
| [Logs][lgs]            | CloudWatch Logs                   |
| [Route53][r53]         | Route 53                          |
| [Route53 Record][r53r] | Route 53 Record                   |
| [ACM][acm]             | AWS Certificate Manager           |

[aws]: https://aws.amazon.com/
[iam]: ./modules/iam
[plc]: ./modules/policy
[vpc]: ./modules/vpc
[sg]: ./modules/security-group
[s3]: ./modules/s3
[cf]: ./modules/cloudfront
[rds]: ./modules/rds
[kp]: ./modules/keypair
[ec2]: ./modules/ec2
[ecr]: ./modules/ecr
[ecs]: ./modules/ecs
[elb]: ./modules/loadbalancer
[lgs]: ./modules/logs
[r53]: ./modules/route-53
[r53r]: ./modules/route-53-record
[acm]: ./modules/acm

## Installation
- Generate SSH for EC2 instances in ECS
	```
	ssh-keygen -t ed25519 -f ~/.ssh/terrajet_dev_ec2_id_ed25519 -e -m pem
	```

## FAQ
### Q: Why ECS is used for monolith app?
Deploying an app on AWS using EC2 is a commonly used and straightforward approach. However, it can be challenging to maintain and scale, particularly when working with Docker containers. On the other hand, ECS cluster may appear more complex at first glance, but it actually simplifies the process. With ECS, you leave all the container control tasks for it, allowing you to focus on your code.
### Q: Why is ECS but not Kubernetes?
Although Kubernetes is popular and strongest for container clusters, but it's not necessary for our regular workload. It's resource-intensive and better suited for large-scale projects with a dedicated DevOps team. ECS is simpler and suitable for small to medium-sized monolithic apps.
