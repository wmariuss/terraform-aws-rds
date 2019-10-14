output "instance_id" {
  value = "${module.rds.instance_id}"
}

output "instance_address" {
  value = "${module.rds.instance_address}"
}

output "instance_endpoint" {
  value = "${module.rds.instance_endpoint}"
}

output "db_password" {
  value = "${module.rds.db_password}"
}
