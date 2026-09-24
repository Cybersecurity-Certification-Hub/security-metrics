package cch.metrics.acceptable_use_policy_documented

import data.cch.comparison_result
import rego.v1
import input.acceptableUsePolicy as acceptableUsePolicy

default applicable := false
default compliant := false

applicable if {
	"isDefined" in object.keys(acceptableUsePolicy)
	is_boolean(acceptableUsePolicy.isDefined)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "A formal procedure documenting acceptable use of information and company assets exists." if {
	compliant
} else := "No formal procedure documenting acceptable use of information and company assets exists." if {
	not compliant
}

results := [comparison_result("acceptableUsePolicy.isDefined", acceptableUsePolicy.isDefined)]
