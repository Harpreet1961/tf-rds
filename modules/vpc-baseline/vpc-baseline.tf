# # Creating VPC.
# resource "aws_vpc" "vpc" {
#   count = var.enabled ? 1 : 0
#   cidr_block           = var.cidr_vpc
#   #cidr_block           = var.vpc-cidr
#   instance_tenancy     = var.instance-tenancy
#   enable_dns_support   = var.enable-dns-support
#   enable_dns_hostnames = var.enable-dns-hostnames
       
#   tags = {
#     Name = var.vpc_name
#   }
# }

locals {
  vpc_obj = flatten(
   [
     for k in aws_vpc.vpc: [
           {
              vpc_id = k.id
           }
     ]
   ]
 )
}

# Creating VPC.vpc
resource "aws_vpc" "vpc" {
  for_each  =   { for k, v in var.tfc_vpc_object : k => v if var.vpc_enabled}
  cidr_block           = "${each.value.cidr_vpc}"
  instance_tenancy     = "${each.value.instance-tenancy}"
  enable_dns_support   = "${each.value.enable-dns-support}"
  enable_dns_hostnames = "${each.value.enable-dns-hostnames}"
       
  tags = {
    Name = "${each.value.vpc_name}"
  }
}
# Creating Secondary CIDR Blocks to VPC

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  for_each  =   { for k, v in var.tfc_vpc_object : k => v if var.vpc_enabled}
  vpc_id = "${local.vpc_obj[0].vpc_id}"
  cidr_block = "${each.value.secondcidr_vpc}"
  

}

/*# Creating Public Subnet.
resource "aws_subnet" "demo-public-subnet" {

  #vpc_id     = aws_vpc.demo-vpc.id
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = var.public_subnets
  map_public_ip_on_launch = var.enable
  tags = {
    Name = var.public_subnet_name
  }
}*/


# Creating Private Subnet
/*resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = var.private_subnets
  map_public_ip_on_launch = false

  tags = {
    "Name" = var.private_subnet_name
  }


  
}*/


# resource "aws_subnet" "private-subnet" {
#   for_each  =   { for k, v in var.tfc_subnet_object : k => v if var.vpc_enabled}
#   count             = var.enabled && length(var.vpc-private-subnet-cidr) > 0 ? length(var.vpc-private-subnet-cidr) : 0
#   availability_zone = data.aws_availability_zones.azs.names[count.index]
#   cidr_block        = var.vpc-private-subnet-cidr[count.index]
#   vpc_id            = aws_vpc.vpc[0].id
#   map_public_ip_on_launch = false

#   tags = {
#     count = length(var.vpc-private-subnet-cidr)
#     "Name" = "${var.private_subnet_name}-${count.index + 1}"
#   }
# }

resource "aws_subnet" "private-subnet" {
  for_each  =   { for k, v in var.tfc_subnet_object : k => v if var.vpc_enabled}
  availability_zone = "${each.value.availability_zone}"
  cidr_block        = "${each.value.vpc-private-subnet-cidr}"
  vpc_id            = "${local.vpc_obj[0].vpc_id}"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${each.value.private_subnet_name}"
  }
}



/*# Creating Internet Gateway.
resource "aws_internet_gateway" "demo_igw" {
  #vpc_id = aws_vpc.demo-vpc.id
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  tags = {
    Name = var.internet_gateway
  }
}*/

# Creating Infra Subnets

resource "aws_subnet" "Infra" {
  for_each  =   { for k, v in var.tfc_subnet_object : k => v if var.vpc_enabled}
  availability_zone = "${each.value.availability_zone}"
  cidr_block        = "${each.value.vpc-infra-subnet-cidr}"                  
  vpc_id            = "${local.vpc_obj[0].vpc_id}"
  map_public_ip_on_launch = false

  #vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  #cidr_block = var.cidr_infra

  tags = {
    "Name" = "${each.value.infra-subnets}"
  }
  
   
}


# resource "aws_route_table" "private-routes" {
#   for_each  =   { for k, v in var.tfc_subnet_object : k => v if var.vpc_enabled}
#   vpc_id = "${local.vpc_obj[0].vpc_id}"
   
#   #vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
#   tags = {
#     "Name" = "${each.value.pvt-route-name}"
#   }

#   lifecycle {
#     # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
#     # resources that manipulate the attributes of the routing table (typically for the private subnets)
#     ignore_changes = [propagating_vgws]
#   }
# }

# resource "aws_route_table" "infra-routes" {
#   for_each  =   { for k, v in var.tfc_subnet_object : k => v if var.vpc_enabled}
#   vpc_id = "${local.vpc_obj[0].vpc_id}"
#   #vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
#   tags = {
#     "Name" = "${each.value.infra-route-name}"
#   }

#   lifecycle {
#     # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
#     # resources that manipulate the attributes of the routing table (typically for the private subnets)
#     ignore_changes = [propagating_vgws]
#   }
# }




# data "aws_subnet_ids" "subnet-ids" {

#   vpc_id = "${local.vpc_obj[0].vpc_id}"

#   filter {
#     name   = "tag:Name"
#     values = ["*private*","*private1*"]
#   }

  
# }

# data "aws_vpc_endpoint_service" "s3Interface" {
#   #service = "s3"
#   service = "s3"
#  # service_type = "Interface" 
#   service_type ="Gateway"
# }

# # data "aws_security_group" "sg" {
# #    filter {
# #     name   = "tag:Name"
# #     values = ["*sg*","*sg1*"]
# #   }
  
# # }

# data "aws_route_tables" "rt-id" {

#   vpc_id = "${local.vpc_obj[0].vpc_id}"

#   filter {

#     name = "tag:Name"
#     values = ["*pvt*","*pvt1*"]
  
#   }
  
# }


# resource "aws_vpc_endpoint" "s3Interface" {
#   vpc_id       = "${local.vpc_obj[0].vpc_id}"
#   service_name = data.aws_vpc_endpoint_service.s3Interface.service_name
#  # vpc_endpoint_type = "Interface" var.vpc-endpoint-type
#   vpc_endpoint_type = "Gateway"

#   route_table_ids = data.aws_route_tables.rt-id.ids

#   tags = {
#     "Name" = "Gateway-Endpoint-s3"
#   }

#  # subnet_ids = data.aws_subnet_ids.subnet-ids.ids
#  # security_group_ids = [data.aws_security_group.sg.id]
#  # security_group_ids =  var.security_id
# }

# # VPC Flow logs destined to CLoudwatch logs

# resource "aws_flow_log" "vpc-flow-logs" {
#   iam_role_arn    = "${aws_iam_role.vpc-flow-logs-role.arn}"
#   log_destination = "${aws_cloudwatch_log_group.cloudwatch-log-groups.arn}"
#   traffic_type    = "ALL"
#   vpc_id          = "${local.vpc_obj[0].vpc_id}"
#   tags = {
#     "Name" = var.flow-log
#   }
# }

# resource "aws_cloudwatch_log_group" "cloudwatch-log-groups" {
#   name = var.cloudwatch-logs-name
# }

# resource "aws_iam_role" "vpc-flow-logs-role" {
#   name = var.flow-log-role-name
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "vpc-flow-logs.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "vpc-flow-logs-policy" {
#   name = "example"
#   role = aws_iam_role.vpc-flow-logs-role.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:DescribeLogGroups",
#         "logs:DescribeLogStreams"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }



/*# Creating route table.
resource "aws_route_table" "demo-PubRoute" {
  #vpc_id = aws_vpc.demo-vpc.id
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
  tags = {
    Name = var.public_route
  }
}

# Creating Route Table for Private Subnets

resource "aws_route_table" "demo-pvtroute" {
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }
  tags = {
    Name = var.private_route
  }
  
  
}


# Route Table Association



resource "aws_route_table_association" "pvt_route_association" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.demo-pvtroute.id
  
}*/



