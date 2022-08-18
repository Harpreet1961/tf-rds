variable "create_low_cpu_credit_alarm" {
  type        = bool
  default     = true
  description = "Whether or not to create the low cpu credit alarm.  Default is to create it (for backwards compatible support)"
}

variable "db_instance_class" {
  type      = string
  description = "The rds instance class, e.g. db.t3.medium"
}

# variable "prefix" {
#   type        = string
#   default     = ""
#   description = "Alarm Name Prefix"
# }

# variable "db_instance_id" {
#   type        = string
#   description = "RDS Instance ID"
# }

# variable "evaluation_period" {
#   type        = string
#   default     = "5"
#   description = "The evaluation period over which to use when triggering alarms."
# }

# variable "statistic_period" {
#   type        = string
#   default     = "60"
#   description = "The number of seconds that make each statistic period."
# }

# variable "cpu_credit_balance_too_low_threshold" {
#   type        = string
#   default     = "100"
#   description = "Alarm threshold for the 'lowCPUCreditBalance' alarm"
# }

variable "actions_alarm" {
  type        = list
  default     = []
  description = "A list of actions to take when alarms are triggered. Will likely be an SNS topic for event distribution."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to each alarm"
}

variable "db_instance_id" {
  type        = string
  description = "RDS Instance ID"
}

variable "tfc_monitor_object" {
  type = map(object({
    # secondcidr_vpc  = string
    prefix = string, 
    evaluation_period = number,
    statistic_period = number,
    cpu_credit_balance_too_low_threshold = number,
    cpu_utilization_too_high_threshold = number,
    disk_queue_depth_too_high_threshold = number,
    disk_free_storage_space_too_low_threshold = number,
    disk_burst_balance_too_low_threshold = number,
    memory_freeable_too_low_threshold = number,
    memory_swap_usage_too_high_threshold = number,
    anomaly_band_width = string
    anomaly_period = string
    maximum_used_transaction_ids_too_high_threshold = number
   # availability_zone = string,
   #  pvt-route-name = string ,
   # infra-route-name = string
  }))
}


variable "create_high_cpu_alarm" {
    type = bool
    default = true
  
}

variable "create_high_queue_depth_alarm" {
    type = bool
    default = true
  
}

variable "create_low_disk_space_alarm" {
    type = bool
    default = true
  
}

variable "create_low_disk_burst_alarm" {
    type = bool
    default = true  
}

variable "create_low_memory_alarm" {
    type = bool
    default = true
  
}

variable "create_swap_alarm" {
    type = bool
    default = true
  
}

variable "create_anomaly_alarm" {
    type = bool
    default = true
  
}