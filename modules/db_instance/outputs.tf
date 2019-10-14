output "instance_id" {
  description = "The ID of the RDS instance"
  value       = "${aws_db_instance.instance.*.id}"
}

output "instance_name" {
  value = "${aws_db_instance.instance.*.identifier}"
}

output "instance_address" {
  description = "The address (aka hostname) of the RDS instance"
  value       = "${aws_db_instance.instance.*.address}"
}

output "instance_endpoint" {
  description = "Endpoint (hostname:port) of the RDS instance"
  value       = "${aws_db_instance.instance.*.endpoint}"
}

output "db_password" {
  value = <<EOF
Go to RDS console and change the password for ${element(concat(aws_db_instance.instance.*.id, list("")), 0)} instance
EOF
}
