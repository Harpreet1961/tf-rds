
# output "rds_id" {
#   value = length(aws_db_instance.postgresql) > 0 ? tomap({
#     for k, v in aws_db_instance.postgresql : k => v.id
#   }) : null  
# }
