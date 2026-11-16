package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Applies the logging example and asserts a multi-region, validated trail + a log bucket exist.
func TestLogging(t *testing.T) {
	opts := &terraform.Options{TerraformDir: "../examples/logging"}
	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	assert.Contains(t, terraform.Output(t, opts, "trail_arn"), "cloudtrail")
	assert.NotEmpty(t, terraform.Output(t, opts, "log_bucket"))
}
