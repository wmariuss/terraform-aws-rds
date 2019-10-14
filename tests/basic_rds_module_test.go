package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func BaicTestTerraformRdsModule(t *testing.T) {
	t.Parallel()

	approvedRegions := "us-east-1"
	expectedName := fmt.Sprintf("terraform-module-automated-test")
	expectedEngine := "postgres"
	expectedEngineVersion := "9.6.11"
	expectedInstanceClass := "db.t2.medium"
	expectedSg := []string{"sg-909e6ada"}
	expectedDbName := "terraformModuleTest"
	expectedDbUser := "terraform"
	expectedDbPass := "a_Strong_Pa33word"
	expectedDbPort := 5432

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/db_instance",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region":                 approvedRegions,
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

		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	actualText := terraform.Output(t, terraformOptions, "instance_name")

	// Verify we're getting back the variable we expect
	assert.Equal(t, expectedName, actualText)
}
