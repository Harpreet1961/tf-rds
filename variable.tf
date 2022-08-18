/*# variables
variable "account_number" {
  type        = string
  description = "AWS Account Number"
}*/

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region for deployments"
}


/*variable "public_subnets" {
  type        = string
  description = "public subnets"
}*/

# variable "vpc-private-subnet-cidr" {
#   type = list(string)
# }

# variable "vpc-infra-subnet-cidr" {
#   type = list(string)
# }


# variable "cidr_vpc" {
#   type        = string
#   description = "cidr of vpc"
# }

# variable "secondcidr_vpc" {
#   type = string
#   description = "Secondary CIDR of VPC"

# }

# /*variable "public_subnet_name" {
#   type        = string
#   description = "public subnet name"
# }*/

# variable "private_subnet_name" {
#   type        = string
#   description = "public subnet name"
# }


# /*variable "internet_gateway" {
#   type        = string
#   description = "internet gateway"
# }

# variable "public_route" {
#   type        = string
#   description = "public route"
# }*/

# variable "vpc_name" {
#   type        = string
#   description = "vpc name"
# }

# /*variable "nat-gateway" {

#   type = string
#   description = "Name of NAT Gateway"

# }

# variable "private_route" {
#   type = string
#   description = "Private Route"

# }
# */
# /*variable "cidr_infra" {
#   type = string
#   description = "CIDR Range of Infra Subnets"

# }*/
# variable "infra-subnets" {
#   type = string
#   description = "Name of Infra"

# }


# /*variable "vpc_id" {
#     type = string

# }*/

# variable "instance-tenancy" {
#   default = "default"
# }
# variable "enable-dns-support" {
#   default = "true"
# }

# variable "enable-dns-hostnames" {
#   default = "true"
# }




# /*variable "transit-name" {
#     type = string

# }

# variable "transit-routes" {
#   type = string
# }

# variable "transit_gateway_id" {

# }
# variable "transit_subnets" {
#   type = list(string)
# }*/


variable "tfc_vpc_object" {
  type = map(object({
    cidr_vpc             = string,
    vpc_name             = string,
    instance-tenancy     = string,
    enable-dns-support   = bool,
    enable-dns-hostnames = bool

    secondcidr_vpc = string,
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
    vpc-infra-subnet-cidr   = string,
    private_subnet_name     = string,
    infra-subnets           = string,
    availability_zone       = string,
    pvt-route-name          = string,
    infra-route-name        = string
  }))
}

variable "tfc_monitor_object" {
  type = map(object({
    # secondcidr_vpc  = string
    prefix                                          = string,
    evaluation_period                               = number,
    statistic_period                                = number,
    cpu_credit_balance_too_low_threshold            = number,
    cpu_utilization_too_high_threshold              = number,
    disk_queue_depth_too_high_threshold             = number,
    disk_free_storage_space_too_low_threshold       = number,
    disk_burst_balance_too_low_threshold            = number,
    memory_freeable_too_low_threshold               = number,
    memory_swap_usage_too_high_threshold            = number
    anomaly_band_width                              = string
    anomaly_period                                  = string
    maximum_used_transaction_ids_too_high_threshold = number
    # availability_zone = string,
    #  pvt-route-name = string ,
    # infra-route-name = string
  }))
}

variable "tfc_rds_object" {
  type = map(object({
    project                    = string,
    environment                = string,
    allocated_storage          = number,
    engine_version             = string,
    instance_type              = string,
    storage_type               = string,
    iops                       = number,
    database_identifier        = string,
    snapshot_identifier        = string,
    database_name              = string,
    database_username          = string,
    #database_password          = string,
    database_port              = number,
    backup_retention_period    = number,
    backup_window              = string,
    maintenance_window         = string,
    auto_minor_version_upgrade = bool,
    final_snapshot_identifier  = string,
    skip_final_snapshot        = bool,
    copy_tags_to_snapshot      = bool,
    #  multi_availability_zone = bool,
    storage_encrypted   = bool,
    deletion_protection = bool,
    #alarm_cpu_threshold = number
    # alarm_disk_queue_threshold = number
    # kms_key_id = string
    #subnet_group = string


    # vpc-private-subnet-cidr = string, 
    # vpc-infra-subnet-cidr = string,
    # private_subnet_name = string,
    # infra-subnets = string
  }))
}

variable "db_instance_class" {
  type        = string
  description = "The rds instance class, e.g. db.t3.medium"
}



# variable "tfc_tgw_object" {
#   type = map(object({
#    # vpc_id  = string,
#     transit_subnets = string,
#     transit-name = string,
#     transit-routes = string,
#     availability_zone = string
#     #transit_gateway_id=string  
#   }))
# }

# variable "vpc_id" {
#   type = string

# }

# variable "tfc-bucket-object" {
#   type = map(object({
#     bucket  = string,
#     #bucket_prefix = string,
#     acl = string,
#     #tags = string,
#     force_destroy  = bool,
#     acceleration_status  = string,
#     request_payer = string,
#     versioning = string,
#     environment_name = string
#     #policy = string
#     # vpc-private-subnet-cidr = string, 
#     # vpc-infra-subnet-cidr = string,
#     # private_subnet_name = string,
#     # infra-subnets = string
#   }))
# }



# variable "tgw-attachment-name" {
#   type = string
# }





# variable "cidr_tgw" {
#   type = string
# }

# variable "cidr_vpc" {
#     type = string

# }

# variable "vpc_id" {
#     type = string

# }

variable "sg_name" {
  type = string

}

#  variable "flow-log" {
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