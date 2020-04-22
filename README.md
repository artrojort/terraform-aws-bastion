# terraform-aws-bastion
Terraform module for launching an AWS Bastion host in an existing VPC.

### Variables 

**Required variables**
| variable | type| description| 
|-|-|-|
project_tag | string | EC2 Tag to identify the project where bastion will be used. 
region | string | AWS Region e.g. us-west-2
subnet_id | string | Public subnet ID where bastion will be launched.
ssh_key | string| SSH Key-Pair name for bastion.
allowed_hosts | list(string) | CIDR blocks of networks trusted to connect to bastion.
internal_networks | list(string) | CIDR blocks of internal networks bastion can discover.

**Other**
| variable | type| description| 
|-|-|-|
instance_type | string | Instance type for bastion server. Defaults to t2.micro.
disk_size | num | Root volume size in GB for bastion server. Defaults to 10.

