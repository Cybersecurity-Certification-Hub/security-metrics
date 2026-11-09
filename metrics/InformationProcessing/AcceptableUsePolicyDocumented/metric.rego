package cch.metrics.acceptable_use_policy_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.acceptableUsePolicy as acceptableUsePolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"documentPurpose" in object.keys(acceptableUsePolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "A formal procedure documenting acceptable use of information and company assets exists." if {
	compliant
} else := "No formal procedure documenting acceptable use of information and company assets exists." if {
	not compliant
}

results := [comparison_result("acceptableUsePolicy.documentPurpose", acceptableUsePolicy.documentPurpose)]
