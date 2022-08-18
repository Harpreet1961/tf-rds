resource "random_password" "this_rds_random_string"{
  length           = 16
  special          = false
 #override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "this_rds_random_password" {
  name = "rds-psql-master-db-secrett1"
}

resource "aws_secretsmanager_secret_version" "this_secret_password" {
  secret_id = aws_secretsmanager_secret.this_rds_random_password.id
  secret_string = random_password.this_rds_random_string.result
}


resource "aws_kms_key" "kms" {
 for_each =  var.tfc_rds_object
 # description = aws_db_instance.postgresql.identifie

  tags = merge(
    {
      Name        = "DatabaseServer",
      Project     = "${each.value.project}",
      Environment = "${each.value.environment}"
    },
    var.tags
  )
}


resource "aws_db_instance" "postgresql" {

  for_each =  var.tfc_rds_object
  allocated_storage               = "${each.value.allocated_storage}"
  engine                          = "postgres"
  engine_version                  = "${each.value.engine_version}"
  identifier                      = "${each.value.database_identifier}"
  snapshot_identifier             ="${each.value.snapshot_identifier}"
  instance_class                  = "${each.value.instance_type}"
  storage_type                    ="${each.value.storage_type}"
  iops                            = "${each.value.iops}"
  name                            = "${each.value.database_name}"
  password                        = aws_secretsmanager_secret_version.this_secret_password.secret_string
  username                        = "${each.value.database_username}"
  backup_retention_period         = "${each.value.backup_retention_period}"
  backup_window                   = "${each.value.backup_window}"
  maintenance_window              = "${each.value.maintenance_window}"
  auto_minor_version_upgrade      = "${each.value.auto_minor_version_upgrade}"
  final_snapshot_identifier       = "${each.value.final_snapshot_identifier}"
  skip_final_snapshot             = "${each.value.skip_final_snapshot}"
  copy_tags_to_snapshot           = "${each.value.copy_tags_to_snapshot}"
  #multi_az                        = "${each.value.multi_availability_zone}"
  multi_az                        =   "${each.value.environment}" == "dev" ? true : false
  port                            = "${each.value.database_port}"
  #vpc_security_group_ids          = [aws_security_group.postgresql.id]
   vpc_security_group_ids          =  ["${var.vpc_security_group_ids}"]
  db_subnet_group_name            = "${var.subnet_group}"
 # parameter_group_name            = var.parameter_group
  storage_encrypted               = "${each.value.storage_encrypted}"
  #kms_key_id                       = (var.replicate_source_db != "")  ? null : aws_kms_key.kms[0].arn
  kms_key_id                      = aws_kms_key.kms[each.key].arn
 # timezone = "UTC+5.30"

  # monitoring_interval             = var.monitoring_interval
#   monitoring_role_arn             = var.monitoring_interval > 0 ? aws_iam_role.enhanced_monitoring.arn : ""
#   deletion_protection             = var.deletion_protection
   enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports

  tags = merge(
    {
      Name        = "DatabaseServer",
      Project     = "${each.value.project}",
      Environment = "${each.value.environment}"
    },
    var.tags
  )
  depends_on = [
    aws_secretsmanager_secret_version.this_secret_password
  ]
}

output "pass" {
  value = aws_secretsmanager_secret_version.this_secret_password.secret_string
  
}



resource "aws_cloudwatch_log_group" "this" {
  #for_each = toset([for log in var.enabled_cloudwatch_logs_exports : log if var.create && var.create_cloudwatch_log_group])
  for_each = {for k, v in var.tfc_rds_object : k => v if var.create_cloudwatch_log_group }

  name              = "/aws/rds/instance/${each.value.database_identifier}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}



# CloudWatch resources

# resource "aws_cloudwatch_metric_alarm" "database_cpu" {
#   for_each =  var.tfc_rds_object
#   alarm_name = "alarm${each.value.environment}DatabaseServerCPUUtilization-${each.value.database_identifier}"
#   alarm_description = "Database server CPU utilization"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods = "1"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/RDS"
#   period = "300"
#   statistic = "Average"
#   threshold = "${each.value.alarm_cpu_threshold}"

#   dimensions = {
#     DBInstanceIdentifier = aws_db_instance.postgresql[each.key].id
#   }



  
  
# }


# resource "aws_cloudwatch_metric_alarm" "database_disk_queue" {
#   for_each =  var.tfc_rds_object
#   alarm_name = "alarm${each.value.environment}DatabaseServerDiskQueueDepth-${each.value.database_identifier}"
#   alarm_description   = "Database server disk queue depth"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "DiskQueueDepth"
#   namespace           = "AWS/RDS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "${each.value.alarm_disk_queue_threshold}"

#   dimensions = {
#     DBInstanceIdentifier = aws_db_instance.postgresql[each.key].id
#   }

# }

