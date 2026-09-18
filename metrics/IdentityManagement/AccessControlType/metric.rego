package cch.metrics.access_control_type

import data.cch.comparison_result
import rego.v1
import input.accessControlTypePolicy as accessControlTypePolicy

default applicable := false

default compliant := false

applicable if {
    accessControlTypePolicy.authorizationTypes
    "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The access control type is appropriately configured with one of the approved types (RBAC, DAC, or MAC)." if {
    compliant
} else := "The access control type is not configured with one of the approved types (RBAC, DAC, or MAC)." if {
    not compliant
}

results := [comparison_result("accessControlTypePolicy.authorizationTypes", accessControlTypePolicy.authorizationTypes)]
