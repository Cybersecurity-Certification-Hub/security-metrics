package cch.metrics.sdn_function_validation_policy_presence

import data.cch.all_compliant
import data.cch.comparison_result
import input.sdnFunctionValidationPolicy as sdnFunctionValidationPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"isDefined" in object.keys(input.sdnFunctionValidationPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines a validation and testing policy for SDN functions." if {
	compliant
} else := "The policy document does not define a validation and testing policy for SDN functions." if {
	not compliant
}

results := [comparison_result("sdnFunctionValidationPolicy.isDefined", sdnFunctionValidationPolicy.isDefined)]
