package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Applies the network example into a sandbox and asserts flow logs + a VPC exist, then destroys.
func TestNetwork(t *testing.T) {
	opts := &terraform.Options{TerraformDir: "../examples/network"}
	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	assert.NotEmpty(t, terraform.Output(t, opts, "vpc_id"))
	assert.NotEmpty(t, terraform.Output(t, opts, "flow_log_id"))
}
