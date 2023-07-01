# Terraform AWS Template

A set of Terraform predefined modules used for provisioning web application stacks on [AWS](https://aws.amazon.com/).

![diagram](images/diagram.png)

The templates are used for creating and managing AWS infrastructure.

## Supported Services

These AWS services are supported by current version.

| Name | Description           |
| ---- | --------------------- |
| VPC  | Virtual Private Cloud |
| EC2  | EC2 Instance          |

## Components

These components are shared by all environments.

| Name              | Description                   | Optional |
| ----------------- | ----------------------------- | :------: |
| [provider.tf][mp] | AWS provider                  |          |
| [main.tf][mm]     | AWS provider, output          |          |
| [outputs.tf][mo]  | Output variables after deploy |          |  |

### modules

#### VPC
| Name                | Description                               | Optional |
| ------------------- | ----------------------------------------- | :------: |
| [main.tf][vm]       | VPC                                       |          |
| [data-zone.tf][vdz] | Existing data zone                        |          |
| [subnet.tf][vs]     | Subnet                                    |          |
| [route.tf][vr]      | Route table                               |          |
| [gateway.tf][vgw]   | Elastic IP, NAT Gateway, Internet Gateway |          |
| [endpoints.tf][vep] | VPC Endpoints                             |   True   |
| [locals.tf][vl]     | Local variables                           |          |
| [variables.tf][vv]  | Input variables                           |          |
| [outputs.tf][vo]    | Output variables                          |          |

#### ec2
| Name               | Description          | Optional |
| ------------------ | -------------------- | :------: |
| [main.tf][em]      | EC2 instance         |          |
| [ebs.tf][eeb]      | Elastic Blob Storage |          |
| [eip.tf][eip]      | Elastic IP           |   True   |
| [variables.tf][ev] | Input variables      |          |
| [outputs.tf][eo]   | Output variables     |          |

#### vars
| Name                | Description            | Optional |
| ------------------- | ---------------------- | :------: |
| [vars.tf][vaev]     | Environment definition |          |
| [variables.tf][vav] | Input variables        |          |
| [outputs.tf][vao]   | Output variables       |          |
| [dev.tf][vad]       | Dev environment        |          |

## Usage

Typically, the base Terraform will only need to be run once, and then should only
need changes very infrequently. After the base is built, each environment can be built.

```
# Sets up Terraform to run
$ terraform init

# Executes the Terraform run
$ terraform apply
```

[aws]: https://aws.amazon.com/
[mp]: ./provider.tf
[mm]: ./main.tf
[mo]: ./outputs.tf