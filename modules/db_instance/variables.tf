variable "region" {
  default = "us-east-1"
}

variable "shared_credentials_file" {
  description = "File that contains AWS credentials"
  default     = "~/.aws/credentials"
}

variable "profile" {
  description = "Specify the profile to apply write AWS credentials"
  default     = "default"
}


variable "instance_name" {
  description = "Custom name of the instance"
  default     = ""
}

variable "multi_az" {
  description = "pecifies if the RDS instance is multi AZ"
  default     = false
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  default     = 0
}

variable "allocated_storage" {
  description = "The allocated storage in GBs"
  default     = 60
}

variable "engine_type" {
  description = "Database engine type"
  default     = "postgres"
  # Valid types are
  # - mysql
  # - postgres
  # - oracle-*
  # - sqlserver-*
  # See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # --engine
}

variable "engine_version" {
  description = "Database engine version, depends on engine type"
  default     = "9.6.3"
  # For valid engine versions, see:
  # See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # --engine-version
}

variable "instance_class" {
  description = "Class of RDS instance"
  default     = "db.t2.medium"
  # Valid values
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

variable "auto_minor_version_upgrade" {
  description = "Allow automated minor version upgrade"
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "sat:10:15-sat:10:45"
}

variable "database_name" {
  description = "The name of the database to create"
  default     = ""
}

variable "database_user" {
  description = "Username for the master DB user"
  default     = ""
}

variable "database_port" {
  description = "The port on which the DB accepts connections"
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  default     = ""
}

variable "publicly_accessible" {
  description = "Determines if database can be publicly available"
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups ID to associate"
  type        = "list"
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  default     = ""
}

variable "skip_final_snapshot" {
  description = "If true (default), no snapshot will be made before deleting DB"
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags from DB to a snapshot"
  default     = false
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "05:10-05:40"
}

variable "backup_retention_period" {
  description = "How long will we retain backups"
  default     = 1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "monitoring_interval" {
  description = "To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero"
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled"
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  default     = false
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  default     = false
}

variable "random_string_length" {
  description = "The length of the string desired"
  default     = 16
}

variable "random_string_special" {
  description = "Include special characters in random string. These are '!@#$%&*()-_=+[]{}<>:?'"
  default     = true
}
