output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${module.aws_rds.this_db_instance_endpoint}"
}
