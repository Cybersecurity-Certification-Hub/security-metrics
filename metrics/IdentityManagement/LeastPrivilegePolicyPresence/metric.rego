package cch.metrics.least_privilege_policy_presence

import data.cch.compare
import rego.v1
import input.leastPrivilegePolicy as leastPrivilegePolicy

default applicable := false
default compliant := false

applicable if {
	leastPrivilegePolicy
	"PolicyDocument" in input.type
}

compliant if {
	compare(data.operator, data.target_value, leastPrivilegePolicy.isDefined)
}

message := "The policy document defines a least privilege policy." if {
	compliant
} else := "The policy document does not define a least privilege policy." if {
	not compliant
}
