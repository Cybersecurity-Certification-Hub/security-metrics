package cch.metrics.least_privilege_policy_presence

import data.cch.comparison_result
import rego.v1
import input.leastPrivilegePolicy as leastPrivilegePolicy

default applicable := false
default compliant := false

applicable if {
	"isDefined" in object.keys(input.leastPrivilegePolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines a least privilege policy." if {
	compliant
} else := "The policy document does not define a least privilege policy." if {
	not compliant
}

results := [comparison_result("leastPrivilegePolicy.isDefined", leastPrivilegePolicy.isDefined)]
