package cch.metrics.need_to_know_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.NeedToKnowPolicy
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.NeedToKnowPolicy.isDefined)
}

message := "The policy document defines a need-to-know policy." if {
	compliant
} else := "The policy document does not define a need-to-know policy." if {
	not compliant
}
