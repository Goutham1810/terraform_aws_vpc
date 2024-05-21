# Project Variables

variable "project_name" {

    type = string
}

variable "environment" {

    type = string
    default = "dev"
  
}

variable "common_tags" {

    type = map

  
}

# VPC Variables

variable "vpc_cidr" {

    type = string
    default = "10.0.0.0/16"
  
}

variable "enable_dns_hostnames" {


    type = bool
    default = true
  
}

variable "vpc_tags" {

  type = map
  default = {}
}


#GateWay variables

variable "vpc_igw_tags" {

    type = map
    default = {}
  
}

# Public Subnets variables

variable "public_subnet_cidrs" {
    type = list
    validation {
        
        condition = length(var.public_subnet_cidrs) == 2
        error_message = "Please provide 2 valid public subnets CIDR"

    }
  
}

variable "public_vpc_cidr_tags" {

    type = map
    default = {}
  
}


# private subnet tags

variable "private_subnet_cidrs" {
    type = list
    validation {
        
        condition = length(var.private_subnet_cidrs) == 2
        error_message = "Please provide 2 valid public subnets CIDR"

    }
  
}

variable "private_vpc_cidr_tags" {

    type = map
    default = {}
  
}


# database subnet tags

variable "database_subnet_cidrs" {
    type = list
    validation {
        
        condition = length(var.database_subnet_cidrs) == 2
        error_message = "Please provide 2 valid public subnets CIDR"

    }
  
}

variable "database_vpc_cidr_tags" {

    type = map
    default = {}
  
}

variable "database_subnet_group_tags" {

    type = map
    default = {}
  
}

#nat gateway tags

variable "nat_gateway_tags" {

    type = map
    default = {}
  
}

#public rout table

variable "public_route_table_tags" {

    type = map
    default = {}

  
}

#private rout table

variable "private_route_table_tags" {

    type = map
    default = {}
    
  
}

# database rout table

variable "database_route_table_tags" {

    type = map
    default = {}
    
  
}

# peering variables

variable "is_peering_required" {

    type = bool
    default = false
  
}

variable "acceptor_vpc_id" {

    type = string
    default = ""
  
}

variable "vpc_peering_tags" {

    type = map
    default = {}
  
}