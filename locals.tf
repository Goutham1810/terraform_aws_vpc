locals {
  resource_name = "${var.project_name}"
  az_names = slice(data.aws_availability_zones.avilable.names,0,2)
  
}