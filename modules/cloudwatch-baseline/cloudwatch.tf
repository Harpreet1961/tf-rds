# resource "aws_cloudwatch_metric_alarm" "cpu_credit_balance_too_low" {
#   count               = var.create_low_cpu_credit_alarm ? length(regexall("(t2|t3)", var.db_instance_class)) > 0 ? 1 : 0 : 0
#   alarm_name          = "${var.prefix}rds-${var.db_instance_id}-lowCPUCreditBalance"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = var.evaluation_period
#   metric_name         = "CPUCreditBalance"
#   namespace           = "AWS/RDS"
#   period              = var.statistic_period
#   statistic           = "Average"
#   threshold           = var.cpu_credit_balance_too_low_threshold
#   alarm_description   = "Average database CPU credit balance is too low, a negative performance impact is imminent."
#  # alarm_actions       = var.actions_alarm
#  # ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }

// CPU Utilization
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_high_cpu_alarm }
    alarm_name          = "${each.value.prefix}rds-highCPUUtilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.cpu_utilization_too_high_threshold}"
    alarm_description   = "Average database CPU utilization is too high."
    alarm_actions       = var.actions_alarm
   # ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}


resource "aws_cloudwatch_metric_alarm" "cpu_credit_balance_too_low" {
    for_each  =   { for k, v in var.tfc_monitor_object : k => v if var.create_low_cpu_credit_alarm || length(regexall("(t2|t3)", var.db_instance_class)) > 0 }
    alarm_name = "${each.value.prefix}rds-lowCPUCreditBalance"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "CPUCreditBalance"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.cpu_credit_balance_too_low_threshold}"
    alarm_description   = "Average database CPU credit balance is too low, a negative performance impact is imminent."
    alarm_actions       = var.actions_alarm

    dimensions = {
     DBInstanceIdentifier = var.db_instance_id
   }
   tags = var.tags



  
}

// Disk Utilization
resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_high_queue_depth_alarm }
    
    #   for_each  =   { for k, v in var.tfc_vpc_object : k => v if var.vpc_enabled}

    alarm_name          = "${each.value.prefix}rds-highDiskQueueDepth"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "DiskQueueDepth"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.disk_queue_depth_too_high_threshold}"
    alarm_description   = "Average database disk queue depth is too high, performance may be negatively impacted."
    alarm_actions       = var.actions_alarm
 # ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "disk_free_storage_space_too_low" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_low_disk_space_alarm }
    alarm_name          = "${each.value.prefix}rds-lowFreeStorageSpace"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "FreeStorageSpace"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.disk_free_storage_space_too_low_threshold}"
    alarm_description   = "Average database free storage space is too low and may fill up soon."
    alarm_actions       = var.actions_alarm
  #  ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "disk_burst_balance_too_low" {
    for_each = {for k , v in var.tfc_monitor_object : k => v if var.create_low_disk_burst_alarm }
 # count               = var.create_low_disk_burst_alarm ? 1 : 0
   alarm_name          = "${each.value.prefix}rds-lowEBSBurstBalance"
   comparison_operator = "LessThanThreshold"
   evaluation_periods  = "${each.value.evaluation_period}"
   metric_name         = "BurstBalance"
   namespace           = "AWS/RDS"
   period              = "${each.value.statistic_period}"
   statistic           = "Average"
   threshold           = "${each.value.disk_burst_balance_too_low_threshold}"
   alarm_description   = "Average database storage burst balance is too low, a negative performance impact is imminent."
   alarm_actions       = var.actions_alarm
  # ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}

// Memory Utilization
resource "aws_cloudwatch_metric_alarm" "memory_freeable_too_low" {
    for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_low_memory_alarm }
    alarm_name          = "${each.value.prefix}rds-lowFreeableMemory"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "FreeableMemory"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.memory_freeable_too_low_threshold}"
    alarm_description   = "Average database freeable memory is too low, performance may be negatively impacted."
    alarm_actions       = var.actions_alarm
  #  ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "memory_swap_usage_too_high" {
    for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_swap_alarm }
    alarm_name          = "${each.value.prefix}rds-highSwapUsage"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "SwapUsage"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.memory_swap_usage_too_high_threshold}"
    alarm_description   = "Average database swap usage is too high, performance may be negatively impacted."
    alarm_actions       = var.actions_alarm
 # ok_actions          = var.actions_ok

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = var.tags
}


// Connection Count
resource "aws_cloudwatch_metric_alarm" "connection_count_anomalous" {
    for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_anomaly_alarm }
    alarm_name          = "${each.value.prefix}rds-anomalousConnectionCount"
    comparison_operator = "GreaterThanUpperThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    threshold_metric_id = "e1"
    alarm_description   = "Anomalous database connection count detected. Something unusual is happening."
    alarm_actions       = var.actions_alarm
   # ok_actions          = var.actions_ok

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1, ${each.value.anomaly_band_width})"
    label       = "DatabaseConnections (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "DatabaseConnections"
      namespace   = "AWS/RDS"
      period      = "${each.value.anomaly_period}"
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        DBInstanceIdentifier = var.db_instance_id
      }
    }
  }
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "maximum_used_transaction_ids_too_high" {
    for_each = var.tfc_monitor_object
 # count               = contains(["aurora-postgresql", "postgres"], var.engine) ? 1 : 0
    alarm_name          = "${each.value.prefix}rds-maximumUsedTransactionIDs"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "${each.value.evaluation_period}"
    metric_name         = "MaximumUsedTransactionIDs"
    namespace           = "AWS/RDS"
    period              = "${each.value.statistic_period}"
    statistic           = "Average"
    threshold           = "${each.value.maximum_used_transaction_ids_too_high_threshold}"
    alarm_description   = "Nearing a possible critical transaction ID wraparound."
    alarm_actions       = var.actions_alarm
  #  ok_actions          = var.actions_ok
}


