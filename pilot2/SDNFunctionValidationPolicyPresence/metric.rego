package cch.metrics.sdn_function_validation_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.SDNFunctionValidationPolicy
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.SDNFunctionValidationPolicy.isDefined)
}

message := "The policy document defines a validation and testing policy for SDN functions." if {
	compliant
} else := "The policy document does not define a validation and testing policy for SDN functions." if {
	not compliant
}
