package cch.metrics.least_privilege_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.LeastPrivilegePolicy
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.LeastPrivilegePolicy.isDefined)
}

message := "The policy document defines a least privilege policy." if {
	compliant
} else := "The policy document does not define a least privilege policy." if {
	not compliant
}
