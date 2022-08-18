# # Define Variables
# aws_region         = "us-east-1"
# #ccount_number     = ""
# cidr_vpc           = "10.11.0.0/16"
# secondcidr_vpc     = "172.0.0.0/16"
# #public_subnets     = "10.0.0.0/28"
# #private_subnets    =  "10.0.1.0/24"
# vpc-private-subnet-cidr =["10.11.4.0/24","10.11.5.0/24"]
# vpc-infra-subnet-cidr = ["10.11.7.0/24", "10.11.8.0/24"]
# vpc_name           = "demo-vpc"
# #public_subnet_name = "demo-public-subnet"
# private_subnet_name = "demo-private-subnet"
# #internet_gateway   = "demo-igw"
# #public_route       = "demo-PubRoute"
# #nat-gateway        = "demo-Nat"
# #private_route      = "demo-Pvtroute" 
# #cidr_infra         = "10.0.0.0/24"
# infra-subnets      = "Infra-Demo"
# #transit_subnets    = ["10.0.2.0/24","10.0.3.0/24"]
# #transit-name       = "demo_tgwsub"
# #transit-routes      = "demo-tgwroutetable"
# #transit_gateway_id = "tgw-0abf6b836f81eb889"
# #vpc_id             = module.tf-connect-vpc.vpc_id

tfc_vpc_object = {
  "vpc_object" = {
    cidr_vpc             = "10.142.53.0/24"
    instance-tenancy     = "default"
    vpc_name             = "test-vpc"
    enable-dns-support   = true
    enable-dns-hostnames = true
    secondcidr_vpc       = "172.0.0.0/16"
    # vpc-private-subnet-cidr = "10.11.4.0/24"
    # vpc-infra-subnet-cidr = "10.11.7.0/24"
    # private_subnet_name = "demo-private-subnet"
    # infra-subnets = "Infra-Demo"    
  }
}




tfc_subnet_object = {
  "primary_subnet_object" = {
    # secondcidr_vpc  = "172.0.0.0/16"
    vpc-private-subnet-cidr = "10.142.53.64/28"
    vpc-infra-subnet-cidr   = "10.142.53.112/28"
    private_subnet_name     = "demo-private-subnet1"
    availability_zone       = "us-west-2a"
    infra-subnets           = "Infra-Demo1"
    pvt-route-name          = "pvt-route-table1",
    infra-route-name        = "infra-route-table1"
  },
  "secondary_subnet_object" = {
    # secondcidr_vpc  = "172.0.0.0/16"
    vpc-private-subnet-cidr = "10.142.53.80/28"
    vpc-infra-subnet-cidr   = "10.142.53.128/28"
    private_subnet_name     = "demo-private-subnet3"
    availability_zone       = "us-west-2b"
    infra-subnets           = "Infra-Demo3"
    pvt-route-name          = "pvt-route-table3",
    infra-route-name        = "infra-route-table3"
  }


}

tfc_rds_object = {
  "primary_database" = {
    project                    = "Something1",
    environment                = "Staging",
    allocated_storage          = "32",
    engine_version             = "13.4",
    instance_type              = "db.t3.micro",
    storage_type               = "gp2",
    iops                       = "0",
    database_identifier        = "rds",
    snapshot_identifier        = "",
    database_name              = "hector",
    database_username          = "hector",
   # database_password          = "secret12345",
    database_port              = "5432",
    backup_retention_period    = "30",
    backup_window              = "04:00-04:30",
    maintenance_window         = "sun:04:30-sun:05:30",
    auto_minor_version_upgrade = false,
    final_snapshot_identifier  = "terraform-aws-postgresql-rds-snapshot",
    skip_final_snapshot        = true,
    copy_tags_to_snapshot      = false,
    # multi_availability_zone = false,
    storage_encrypted   = true,
    deletion_protection = true,
    # alarm_cpu_threshold = "75"
    #  alarm_disk_queue_threshold = "10"
    #subnet_group = string


    # vpc-private-subnet-cidr = string, 
    # vpc-infra-subnet-cidr = string,
    # private_subnet_name = string,
    # infra-subnets = string
  }
}

tfc_monitor_object = {
  primary_data = {
    # secondcidr_vpc  = string
    prefix                                          = "",
    evaluation_period                               = "5",
    statistic_period                                = "60",
    cpu_credit_balance_too_low_threshold            = "100",
    cpu_utilization_too_high_threshold              = "75"
    disk_queue_depth_too_high_threshold             = "10"
    disk_free_storage_space_too_low_threshold       = "10000000000" // 10GB
    disk_burst_balance_too_low_threshold            = "100"
    memory_freeable_too_low_threshold               = "256000000" // 256 MB,
    memory_swap_usage_too_high_threshold            = "256000000" // 256 MB
    anomaly_band_width                              = "2"
    anomaly_period                                  = "600"
    maximum_used_transaction_ids_too_high_threshold = "1000000000" // 1 billion. Half of total
    # availability_zone = string,
    #  pvt-route-name = string ,
    # infra-route-name = string
  }
}
# tfc_tgw_object = {
#     "transit_subnets_object" ={
#     #vpc_id  = string,
#     transit-name = "tgw-subnet1"
#     transit_subnets = "10.142.53.16/28"
#     transit-routes = "transit-route-table1"
#     availability_zone = "us-west-2b"
#     #transit_gateway_id="tgw-01a5fc3e6e83e1b31"

#   },
#     "transit_sec_subnets_object" ={
#     #vpc_id  = string,
#     transit-name = "tgw-subnet2"
#     transit_subnets = "10.142.53.32/28"
#     transit-routes = "transit-route-table2"
#     availability_zone = "us-west-2c"

# }

# }

db_instance_class = "db.t3.micro"

#     tfc-bucket-object = {
#     "bucket_object" = {
#     bucket  = "sudha-tf-10-7-2022"
#     bucket_prefix = "test"
#     acl = "private"
#    # tags = "test-bucket"
#     force_destroy  = "false" 
#     acceleration_status  = "Suspended",
#     request_payer = "BucketOwner"
#     versioning = "Enabled"
#     environment_name = "Dev"
#     #policy = "null"
#     # vpc-private-subnet-cidr = "10.11.4.0/24"
#     # vpc-infra-subnet-cidr = "10.11.7.0/24"
#     # private_subnet_name = "demo-private-subnet"
#     # infra-subnets = "Infra-Demo"    
#   },

#   "bucket_devops_object" = {
#     bucket  = "sudha-devops-tf-10-7-2022"
#     bucket_prefix = "test2"
#     acl = "public-read"
#    # tags = "devops-bucket"
#     force_destroy  = "false" 
#     acceleration_status  = "Suspended",
#     request_payer = "BucketOwner"
#     versioning = "Suspended"
#     environment_name = "Test"
# }

#     }








# tgw-attachment-name = "tgw-attachment"
sg_name = "sg-vpc"
# flow-log = "test-vpc-flow-logs"
# cloudwatch-logs-name = "test-cloudwatch-logs"
# flow-log-role-name  =  "test-vpc-flow-log-role"

# # cidr_vpc = "10.11.0.0/16"

# service-name = "s3"
# service-type = "Interface"
# vpc-endpoint-type = "Interface"
