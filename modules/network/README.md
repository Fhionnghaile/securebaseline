# network

VPC with public/private subnets across AZs, **VPC flow logs** to CloudWatch, and a **locked-shut
default security group** (zero ingress/egress).

| input | type | default | description |
|---|---|---|---|
| `name` | string | — | name prefix |
| `cidr` | string | `10.0.0.0/16` | VPC CIDR |
| `azs` | list(string) | — | AZs to spread subnets across |
| `tags` | map(string) | `{}` | tags |

| output | description |
|---|---|
| `vpc_id` | the VPC id |
| `public_subnet_ids` / `private_subnet_ids` | subnet ids |
| `flow_log_id` | the flow log id |
