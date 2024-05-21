
# terraform_aws_vpc
Building an module to build the VPC and other related things through code

** This module is developed for joindevops.com, Below are mentioned resources are been creating as part of code. and to maintain high availability(HA) we are using 2 Aviliability zones(AZ)

* VPC
* Internet Gateway
* Internet and VPC attachment
* 2 public subnets
* 2 private subnets
* 2 database subnets
* Elastic Ip Address [EIP]
* Nat Gateway [NAT]
* Public Rout table
* Private Rout table
* Database Rout table
* Rout table and subnet associations
* Routes in all tables
* Peering if required for user
* Routes peering in requestor and acceptor VPC.

## Inputs

* project_name (Required) : User will provide their project name, Type is string
* environment (Optional): Default value is dev, Type is string
* common_tags (Required): User will provide their tags information, Type is map
* vpc_cidr (Optional): Default value is 10.0.0.0/16, Type is string
* enable_dns_hostnames (Optional): Default value true, Type is bool
* vpc_tags (Optional): Default value is empty, Type is map
* vpc_igw_tags (Optional): Default value is empty, Type is map
* public_subnet_cidrs (Required): User has to provide 2 valid subnet CIDR
* public_vpc_cidr_tags (Optional): Default value is empty, Type is map
* private_subnet_cidrs (Required): User has to provide 2 valid subnet CIDR
* private_vpc_cidr_tags (Optional): Default value is empty, Type is map
* database_subnet_cidrs (Required): User has to provide 2 valid subnet CIDR
* database_vpc_cidr_tags (Optional): Default value is empty, Type is map
* database_subnet_group_tags (Optional): Default value is empty, Type is map
* nat_gateway_tags (Optional): Default value is empty, Type is map.
* public_route_table_tags (Optional): Default value is empty, Type is map.
* private_route_table_tags (Optional): Default value is empty, Type is map.
* database_route_table_tags (Optional): Default value is empty, Type is map.
* is_peering_required (Optional): Default value is false ,Type is bool.
* acceptor_vpc_id (Optional): Default value is empty, default VPC ID would be taken. Type is string.
* vpc_peering_tags (Optional): Default value is empty, Type is map.

## outputs

* vpc_id : VPC ID
* public_subnet_ids: A list of 2 public subnet ID's created
* private_subnet_ids: A list of 2 private subnet ID's created
* database_subnet_ids: A list of 2 database subnet ID's created
* database_subnet_group_id: A database subnet group id will be created.
