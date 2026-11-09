package cch.metrics.least_privilege_policy_presence

import data.cch.all_compliant
import data.cch.comparison_result
import input.leastPrivilegePolicy as leastPrivilegePolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"isDefined" in object.keys(input.leastPrivilegePolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines a least privilege policy." if {
	compliant
} else := "The policy document does not define a least privilege policy." if {
	not compliant
}

results := [comparison_result("leastPrivilegePolicy.isDefined", leastPrivilegePolicy.isDefined)]
