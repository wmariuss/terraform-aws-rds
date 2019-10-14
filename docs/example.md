# Example

```hcl
# Example main.tf file

module "rds" {
  source = "git::https://github.com/wmariuss/terraform-aws-rds.git//modules/db_instance?ref=v1.0.0"

  instance_name = "project_name"

  engine_type    = "postgres"
  engine_version = "9.6.11"
  instance_class = "db.t2.medium"

  database_name     = "db_name"
  database_user     = "terraform"
  database_port     = 5432

  vpc_security_group_ids = ["sg-909e6ada"]

  deletion_protection = false
  publicly_accessible = true

  tags = {
    Owner       = "Marius Stanca"
    Environment = "testing"
  }
}

# Example output.tf file

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

```
