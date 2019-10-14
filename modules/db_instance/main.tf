// terraform-aws-rds module
// Marius Stanca <me@marius.xyz>

terraform {
  required_version = ">= 0.11.8"
}

provider "aws" {
  version                 = ">= 1.52.0, <= 1.60.0"
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.profile}"
}

resource "random_string" "password" {
  length  = "${var.random_string_length}"
  special = "${var.random_string_special}"
}

resource "aws_iam_role" "monitoring_role" {
  count = "${var.create_monitoring_role ? 1 : 0}"

  name               = "${var.monitoring_role_name}"
  assume_role_policy = "${file("${path.module}/policy/monitoringrole.json")}"
}

resource "aws_iam_role_policy_attachment" "monitoring_role" {
  count = "${var.create_monitoring_role ? 1 : 0}"

  role       = "${aws_iam_role.monitoring_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_instance" "instance" {
  count  = "${var.instance_name != "" ? 1 : 0}"

  identifier = "${var.instance_name}"

  engine            = "${var.engine_type}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  
  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"

  name              = "${var.database_name}"
  username          = "${var.database_user}"
  password          = "${var.engine_type != "mysql" ? sha1(bcrypt(random_string.password.result)) : sha256(bcrypt(random_string.password.result))}"
  port              = "${var.database_port}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  parameter_group_name   = "${var.parameter_group_name}"


  availability_zone   = "${var.availability_zone}"
  multi_az            = "${var.multi_az}"
  iops                = "${var.iops}"
  publicly_accessible = "${var.publicly_accessible}"

  // Upgrades
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"

  // Snapshots and backups
  skip_final_snapshot   = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot = "${var.copy_tags_to_snapshot}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"

  // Enhanced monitoring
  monitoring_interval = "${var.monitoring_interval}"
  monitoring_role_arn = "${coalesce(var.monitoring_role_arn, join("", aws_iam_role.monitoring_role.*.arn))}"

  deletion_protection = "${var.deletion_protection}"

  lifecycle {
    ignore_changes = ["password"]
  }

  tags = "${merge(var.tags, map("Name", format("%s", var.instance_name)))}"
}
