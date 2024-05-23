# output "azs" {

#     value = data.aws_availability_zones.avilable.names
  
# }

# Used to know only the information as below
# Changes to Outputs:
#   + az_infomation = [
#       + "us-east-1a",
#       + "us-east-1b",
#       + "us-east-1c",
#       + "us-east-1d",
#       + "us-east-1e",
#       + "us-east-1f",
#     ]

output "vpc_id" {
    value = aws_vpc.main.id
  
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
  
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
  
}

output "database_subnet_ids" {
    value = aws_subnet.database[*].id
  
}
output "database_subnet_group_id" {

    value = aws_db_subnet_group.default.id
  
}

output "database_subnet_group_name" {
  value = aws_db_subnet_group.default.name
}

output "igw_id" {
  value = aws_internet_gateway.gw.id
}