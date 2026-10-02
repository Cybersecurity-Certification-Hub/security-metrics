package cch.metrics.change_approval_before_deployment

import data.cch.comparison_result
import rego.v1
import input.changeAndConfigurationManagement as ccm

default applicable := false
default compliant := false

applicable if {
	"requestForChange" in object.keys(input.changeAndConfigurationManagement)
	"approvedBeforeDeployment" in object.keys(input.changeAndConfigurationManagement.requestForChange)
}

compliant if {
	every r in results {
		r.success
	}
}

message := "Change approval before deployment is properly defined." if {
	compliant
} else := "Change approval before deployment is not properly defined. The value should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"changeAndConfigurationManagement.requestForChange.approvedBeforeDeployment",
		ccm.requestForChange.approvedBeforeDeployment,
	),
] if {
	applicable
}