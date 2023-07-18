# Virtual Private Cloud module

### Components

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

[vm]: main.tf
[vdz]: data-zone.tf
[vs]: subnet.tf
[vr]: route.tf
[vgw]: gateway.tf
[vep]: endpoints.tf
[vl]: locals.tf
[vv]: variables.tf
[vo]: outputs.tf