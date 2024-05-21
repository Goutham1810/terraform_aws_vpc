resource "aws_vpc" "main" {

    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = var.enable_dns_hostnames

    tags = merge(var.common_tags,var.vpc_tags,

        {
            Name = local.resource_name

        }
    )

    }


resource "aws_internet_gateway" "gw" {

    vpc_id = aws_vpc.main.id
    
    tags = merge(
        var.common_tags,var.vpc_igw_tags,
        {
            Name = local.resource_name
        }


    )
  
}


# Public subnets

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = merge(
        var.common_tags,var.public_vpc_cidr_tags,
        {
            Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }


    )
}

#private subnets

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]


    tags = merge(
        var.common_tags,var.private_vpc_cidr_tags,
        {
            Name = "${local.resource_name}-private-${local.az_names[count.index]}"
        }


    )
}

#database subnets

resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.database_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]


    tags = merge(
        var.common_tags,var.database_vpc_cidr_tags,
        {
            Name = "${local.resource_name}-database-${local.az_names[count.index]}"
        }


    )
}

resource "aws_db_subnet_group" "default" {

    name = "${local.resource_name}"
    subnet_ids = aws_subnet.database[*].id

    tags = merge(
        var.common_tags,var.database_subnet_group_tags,
        {
            Name = "${local.resource_name}"
        }


    )

  
}
## routes

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {

    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id
  
  tags = merge(
        var.common_tags,var.nat_gateway_tags,
        {
            Name = "${local.resource_name}" # expense
        }
    )

      # To ensure proper ordering, it is recommended to add an explicit dependency
      
      # on the Internet Gateway for the VPC.

    depends_on = [ aws_internet_gateway.gw ] # Explicit dependency
}

# public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
        var.common_tags,var.public_route_table_tags,
        {
            Name = "${local.resource_name}-public" # expense
        }
    )
}

# private rout table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
        var.common_tags,var.private_route_table_tags,
        {
            Name = "${local.resource_name}-private" # expense
        }
    )
}

# database rout table

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
        var.common_tags,var.database_route_table_tags,
        {
            Name = "${local.resource_name}-database" # expense
        }
    )
}


# rout table association

resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  
}

resource "aws_route" "private_route_nat" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  
}

resource "aws_route" "database_route_nat" {
    route_table_id = aws_route_table.database.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  
}


# route table and subnet associations

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}
