# variable "cidr_vpc" {
#   default = {}
# }

# variable "secondcidr_vpc" {
#   type = string
#   description = "Secondary cidr of  VPC"
  
# }

# variable "enable" {
#   type = bool
#   default = true  
  
# }

# variable "vpc_name" {
#   type        = string
#   description = "vpc name"
# }




# variable "private_subnet_name" {
#   type = string
#   description = "private subnet name"
  
# }


# /*variable "private_route" {
#   type = string
#   description = "Name of Nat Private Route"
  
# }*/


# variable "infra-subnets" {
#   type = string
#   description = "Name of Infra"
  
# }

 variable "vpc_enabled" {
   description = "Controls if VPC should be created (it affects almost all resources)"
   type        = bool
   default = true
 }

# variable "instance-tenancy" {
#   default = "default"
# }
# variable "enable-dns-support" {
#   default = "true"
# }

# variable "enable-dns-hostnames" {
#   default = "true"
# }

# data "aws_availability_zones" "azs" {}

# # VPC Private Subnets Cidr Block List

# variable "vpc-private-subnet-cidr" {
#   type = list(string)
# }

# variable "vpc-infra-subnet-cidr" {
#   type = list(string)
# }

variable "tfc_vpc_object" {
  type = map(object({
    cidr_vpc  = string,
    vpc_name = string,
    instance-tenancy = string,
    enable-dns-support = bool,
    enable-dns-hostnames  = bool,
     secondcidr_vpc  = string,
    # vpc-private-subnet-cidr = string, 
    # vpc-infra-subnet-cidr = string,
    # private_subnet_name = string,
    # infra-subnets = string
  }))
}

variable "tfc_subnet_object" {
  type = map(object({
    # secondcidr_vpc  = string
    vpc-private-subnet-cidr = string, 
    vpc-infra-subnet-cidr = string,
    private_subnet_name = string,
    infra-subnets = string,
    availability_zone = string,
    pvt-route-name = string ,
    infra-route-name = string
  }))
}

# variable "flow-log" {
#   type = string
# }

# variable "cloudwatch-logs-name" {
#   type = string
  
# }

# variable "flow-log-role-name" {
#   type = string
  
# }

# variable "service-name" {
#   type = string
  
# }

# variable "service-type" {
#   type = string
  
# }

# variable "vpc-endpoint-type" {
#   type = string
  
# }

# variable "security_id" {
#   type = string
  
# }

