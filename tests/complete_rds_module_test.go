package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func CompleteTestTerraformRdsModule(t *testing.T) {
	t.Parallel()

	expectedName := fmt.Sprintf("terraform-module-automated-test-%s", strings.ToLower(random.UniqueId()))
	expectedEngine := "postgres"
	expectedEngineVersion := "9.6.11"
	expectedInstanceClass := "db.t2.medium"
	expectedSg := []string{"sg-909e6ada"}
	expectedDbName := "terraformModuleTest"
	expectedDbUser := "terraform"
	expectedDbPass := "a_Strong_Pa33word"
	expectedDbPort := int64(5432)

	awsRegion := "us-east-1"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/db_instance",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"instance_name":          expectedName,
			"engine_type":            expectedEngine,
			"engine_version":         expectedEngineVersion,
			"instance_class":         expectedInstanceClass,
			"vpc_security_group_ids": expectedSg,
			"database_name":          expectedDbName,
			"database_user":          expectedDbUser,
			"database_password":      expectedDbPass,
			"database_port":          expectedDbPort,
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},

		NoColor: true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	dbInstanceID := terraform.Output(t, terraformOptions, "instance_id")

	address := aws.GetAddressOfRdsInstance(t, dbInstanceID, awsRegion)
	port := aws.GetPortOfRdsInstance(t, dbInstanceID, awsRegion)

	// Verify we're getting back the variable we expect
	assert.NotNil(t, address)
	assert.Equal(t, expectedDbPort, port)
}
