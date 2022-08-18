output "vpc_id" {
    value = "${local.vpc_obj[0].vpc_id}"
  
}

# output "cidr_vpc" {
#   value = aws_vpc.vpc.*.cidr_block
# }



#  value = tomap({
#     for k, inst in aws_instance.example : k => inst.id
#   })
/*output "private-subnet-ids" {
  description = "Private Subnets IDS"
  value       = aws_subnet.private-subnets.*.id
}

# Output Of Private Route Table ID's

output "aws-route-table-private-routes-id" {
  value = aws_route_table.private-routes.*.id
}

*/

# Output Of Region AZS

# output "aws-availability-zones" {
#   value = data.aws_availability_zones.azs.names
# }