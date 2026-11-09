package cch.metrics.access_control_type

import data.cch.all_compliant
import data.cch.comparison_result
import input.accessControlTypePolicy as accessControlTypePolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"authorizationTypes" in object.keys(input.accessControlTypePolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The access control type is appropriately configured with one of the approved types (RBAC, DAC, or MAC)." if {
	compliant
} else := "The access control type is not configured with one of the approved types (RBAC, DAC, or MAC)." if {
	not compliant
}

results := [comparison_result("accessControlTypePolicy.authorizationTypes", accessControlTypePolicy.authorizationTypes)]
