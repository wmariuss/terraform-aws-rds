# terraform-aws-rds module

Create RDS instance(s) in AWS Cloud Platform.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allocated\_storage | The allocated storage in GBs | number | `60` | no |
| allow\_major\_version\_upgrade | Allow major version upgrade | bool | `false` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | bool | `false` | no |
| auto\_minor\_version\_upgrade | Allow automated minor version upgrade | bool | `true` | no |
| availability\_zone | The Availability Zone of the RDS instance | string | `""` | no |
| backup\_retention\_period | How long will we retain backups | number | `1` | no |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: `09:46-10:16`. Must not overlap with maintenance_window | string | `"05:10-05:40"` | no |
| copy\_tags\_to\_snapshot | Copy tags from DB to a snapshot | bool | `false` | no |
| create\_monitoring\_role | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | bool | `false` | no |
| database\_name | The name of the database to create | string | `""` | yes |
| database\_port | The port on which the DB accepts connections | number |  | yes |
| database\_user | Username for the master DB user | string | `""` | yes |
| db\_subnet\_group\_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | string | `""` | yes |
| deletion\_protection | The database can't be deleted when this value is set to true | bool | `false` | no |
| engine\_type | Database engine type | string | `"postgres"` | yes |
| engine\_version | Database engine version, depends on engine type | string | `"9.6.3"` | yes |
| instance\_class | Class of RDS instance | string | `"db.t2.medium"` | yes |
| instance\_name | Custom name of the instance | string | `""` | yes |
| iops | The amount of provisioned IOPS. Setting this implies a storage_type of io1 | number | `0` | no |
| kms\_key\_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | string | `""` | no |
| maintenance\_window | The window to perform maintenance in. Syntax: `ddd:hh24:mi-ddd:hh24:mi` UTC | string | `"sat:10:15-sat:10:45"` | no |
| monitoring\_interval | To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60 | number | `0` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero | string | `""` | no |
| monitoring\_role\_name | Name of the IAM role which will be created when create_monitoring_role is enabled | string | `"rds-monitoring-role"` | no |
| multi\_az | pecifies if the RDS instance is multi AZ | bool | `false` | no |
| parameter\_group\_name | Name of the DB parameter group to associate | string | `""` | no |
| profile | Specify the profile to apply write AWS credentials | string | `"default"` | no |
| publicly\_accessible | Determines if database can be publicly available | bool | `false` | no |
| region |  | string | `"us-east-1"` | no |
| shared\_credentials\_file | File that contains AWS credentials | string | `"~/.aws/credentials"` | no |
| skip\_final\_snapshot | If true (default), no snapshot will be made before deleting DB | bool | `true` | no |
| storage\_encrypted | Specifies whether the DB instance is encrypted | bool | `false` | no |
| storage\_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD) | string | `"gp2"` | no |
| tags | A map of tags to add to all resources | map | `{}` | no |
| vpc\_security\_group\_ids | List of VPC security groups ID to associate | list | `[]` | yes |
| random\_string\_length | The length of the string desired | number | `16` | no |
| random\_string\_special | Include special characters in random string. These are `!@#$%&*()-_=+[]{}<>:?`| bool | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| module.rds.instance\_address | The address (aka hostname) of the RDS instance |
| module.rds.instance\_endpoint | Endpoint (hostname:port) of the RDS instance |
| module.rds.instance\_id | The ID of the RDS instance |
| module.rds.instance\_name | The instance name |
| module.rds.db\_password | Message for RDS instance password |

### Example

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

### Tests

#### All tests

* `go test -timeout 30m`
* `go test -timeout 30m -p 1 ./... # For multiple tests with less log output`
* `GOCACHE=off go test -timeout 30m -p 1 ./... # without cache`

#### One test

* `cd tests/`
* `go test -v -run BaicTestTerraformRdsModule # BaicTestTerraformRdsModule = name of function`

### Authors

* [Marius Stanca](mailto:me@marius.xyz)
