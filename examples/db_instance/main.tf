module "rds" {
  source = "../../modules/db_instance"

  instance_name = "terraformmoduletest"

  engine_type    = "postgres"
  engine_version = "9.6.11"
  instance_class = "db.t2.medium"

  database_name     = "terraformModuleTest"
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
